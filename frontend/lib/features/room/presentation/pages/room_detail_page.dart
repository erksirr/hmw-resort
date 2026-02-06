// features/rooms/presentation/pages/room_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemawan_resort/features/room/data/models/room_model.dart';
import 'package:hemawan_resort/features/room/data/repositories/room_repository.dart';
import 'package:hemawan_resort/features/room/presentation/bloc/room_detail/room_detail_bloc.dart';
import 'package:hemawan_resort/features/room/presentation/bloc/room_detail/room_detail_event.dart';
import 'package:hemawan_resort/features/room/presentation/bloc/room_detail/room_detail_state.dart';
import 'package:hemawan_resort/features/room/presentation/widgets/date_selector.dart';
import 'package:hemawan_resort/features/room/presentation/widgets/info_chip.dart';
import 'package:hemawan_resort/shared/widgets/states/error_state.dart';
import 'package:hemawan_resort/shared/widgets/states/loading_state.dart';
import 'package:http/http.dart' as http;

class RoomDetailPage extends StatelessWidget {
  final int roomId;

  const RoomDetailPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    print('=== RoomDetailPage ===');
    print('roomId: $roomId');

    return BlocProvider(
      create:
          (context) =>
              RoomDetailBloc(repository: RoomRepository(client: http.Client()))
                ..add(LoadRoomDetail(roomId)),
      child: const _RoomDetailPageContent(),
    );
  }
}

class _RoomDetailPageContent extends StatefulWidget {
  const _RoomDetailPageContent();

  @override
  State<_RoomDetailPageContent> createState() => _RoomDetailPageContentState();
}

class _RoomDetailPageContentState extends State<_RoomDetailPageContent> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guests = 2;
  Future<void> _selectDate(bool isCheckIn) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = date;
        } else {
          _checkOutDate = date;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RoomDetailBloc, RoomDetailState>(
        builder: (context, state) {
          print('=== RoomDetailState ===');
          print('status: ${state.status}');
          print('roomId: ${state.roomId}');
          print('room: ${state.room?.name}');
          print('isAvailable: ${state.room?.isAvailable}');
          print('error: ${state.errorMessage}');
          print('=======================');

          switch (state.status) {
            case RoomDetailStatus.initial:
            case RoomDetailStatus.loading:
              return const LoadingState(message: 'กำลังโหลดข้อมูล...');
            case RoomDetailStatus.failure:
              return ErrorState(
                title: 'เกิดข้อผิดพลาด',
                message: state.errorMessage,
                onRetry: () {
                  context.read<RoomDetailBloc>().add(const RefreshRoomDetail());
                },
              );
            case RoomDetailStatus.success:
              final room = state.room!;
              return _buildContent(context, room);
          }
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, RoomModel room) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background:
                room.imageUrl.isNotEmpty
                    ? Image.network(
                      room.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 64,
                          ),
                        );
                      },
                    )
                    : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.hotel, size: 64),
                    ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansThai',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          room.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Price
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (room.discountPercentage != null) ...[
                            Text(
                              '฿${room.pricePerNight.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontFamily: 'Lexend',
                              ),
                            ),
                          ],
                          Text(
                            '฿${room.displayPrice.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontFamily: 'Lexend',
                            ),
                          ),
                          Text(
                            'ต่อคืน',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'NotoSansThai',
                            ),
                          ),
                        ],
                      ),
                      if (room.discountPercentage != null)
                        Chip(
                          label: Text('ลด ${room.discountPercentage}%'),
                          backgroundColor: Colors.red,
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'NotoSansThai',
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Room Info
                Text(
                  'ข้อมูลห้องพัก',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansThai',
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    InfoChip(
                      icon: Icons.square_foot,
                      label: '${room.roomSize} ตร.ม.',
                    ),
                    SizedBox(width: 12),
                    InfoChip(icon: Icons.people, label: '${room.maxGuests} คน'),
                    SizedBox(width: 12),
                    InfoChip(
                      icon:
                          room.isAvailable ? Icons.check_circle : Icons.cancel,
                      label: room.isAvailable ? 'ว่าง' : 'ไม่ว่าง',
                    ),
                  ],
                ),
                SizedBox(height: 24),
                // Description
                Text(
                  'รายละเอียด',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansThai',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  room.detail,
                  style: TextStyle(height: 1.5, fontFamily: 'NotoSansThai'),
                ),

                SizedBox(height: 24),

                // Booking Section
                Text(
                  'จองห้องพัก',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansThai',
                  ),
                ),
                SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: DateSelector(
                        label: 'เช็คอิน',
                        date: _checkInDate,
                        onTap: () => _selectDate(true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DateSelector(
                        label: 'เช็คเอาท์',
                        date: _checkOutDate,
                        onTap: () => _selectDate(false),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Guests
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'จำนวนผู้เข้าพัก',
                        style: TextStyle(fontFamily: 'NotoSansThai'),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              if (_guests > 1) {
                                setState(() => _guests--);
                              }
                            },
                          ),
                          Text(
                            '$_guests',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Lexend',
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              if (_guests < room.maxGuests) {
                                setState(() => _guests++);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Book Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed:
                        room.isAvailable
                            ? () {
                              // TODO: Navigate to booking page
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'จองห้อง ${room.name}',
                                    style: TextStyle(
                                      fontFamily: 'NotoSansThai',
                                    ),
                                  ),
                                ),
                              );
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      room.isAvailable ? 'จองเลย' : 'ห้องไม่ว่าง',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NotoSansThai',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
