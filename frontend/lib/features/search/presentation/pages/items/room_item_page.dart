import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemawan_resort/features/room/data/models/room_model.dart';
import 'package:hemawan_resort/features/room/data/models/room_search_params.dart';
import 'package:hemawan_resort/features/room/presentation/bloc/room_search/room_search_bloc.dart';
import 'package:hemawan_resort/features/room/presentation/bloc/room_search/room_search_event.dart';
import 'package:hemawan_resort/features/room/presentation/bloc/room_search/room_search_state.dart';
import 'package:hemawan_resort/shared/widgets/cards/item_card.dart';
import 'package:hemawan_resort/features/search/presentation/models/sort_option.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/body/not_found_search.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/body/sort_dropdown.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/body/custom_filter_button.dart';
import 'package:hemawan_resort/features/room/presentation/pages/room_detail_page.dart';
import 'package:hemawan_resort/shared/widgets/states/error_state.dart';
import 'package:hemawan_resort/shared/widgets/states/loading_state.dart';

class RoomItemPage extends StatefulWidget {
  final int minPrice;
  final int maxPrice;
  final double rating;

  const RoomItemPage({
    super.key,
    this.minPrice = 0,
    this.maxPrice = 10000,
    this.rating = 0,
  });

  @override
  State<RoomItemPage> createState() => _RoomItemPageState();
}

class _RoomItemPageState extends State<RoomItemPage> {
  String _selectedGuestFilter = 'ทั้งหมด';
  String _selectedSort = 'newest';

  static const List<SortOption> _roomSortOptions = [
    SortOption(value: 'newest', label: 'ใหม่ล่าสุด'),
    SortOption(value: 'price_asc', label: 'ราคา: ต่ำ-สูง'),
    SortOption(value: 'price_desc', label: 'ราคา: สูง-ต่ำ'),
    SortOption(value: 'rating', label: 'คะแนนสูงสุด'),
  ];

  RoomSearchParams _buildSearchParams() {
    int? minGuests;
    int? maxGuests;

    switch (_selectedGuestFilter) {
      case '1-2':
        minGuests = 1;
        maxGuests = 2;
        break;
      case '3-4':
        minGuests = 3;
        maxGuests = 4;
        break;
      case '5-8':
        minGuests = 5;
        maxGuests = 8;
        break;
      case '9+':
        minGuests = 9;
        maxGuests = null;
        break;
    }

    String sortBy;
    switch (_selectedSort) {
      case 'price_asc':
      case 'price_desc':
        sortBy = 'price';
        break;
      case 'rating':
        sortBy = 'rating';
        break;
      case 'newest':
      default:
        sortBy = 'createdAt';
        break;
    }

    return RoomSearchParams(
      minGuests: minGuests,
      maxGuests: maxGuests,
      minPrice: widget.minPrice > 0 ? widget.minPrice.toDouble() : null,
      maxPrice: widget.maxPrice < 10000 ? widget.maxPrice.toDouble() : null,
      rating: widget.rating > 0 ? widget.rating : null,
      sortBy: sortBy,
    );
  }

  void _onRoomGuestChanged(String newType) {
    setState(() {
      _selectedGuestFilter = newType;
    });
    context.read<RoomSearchBloc>().add(SearchRooms(_buildSearchParams()));
  }

  void _onSortChanged(String newSort) {
    setState(() {
      _selectedSort = newSort;
    });
    context.read<RoomSearchBloc>().add(SearchRooms(_buildSearchParams()));
  }

  List<RoomModel> _applySorting(List<RoomModel> rooms) {
    final sortedRooms = List<RoomModel>.from(rooms);
    if (_selectedSort == 'price_asc') {
      sortedRooms.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
    } else if (_selectedSort == 'price_desc') {
      sortedRooms.sort((a, b) => b.pricePerNight.compareTo(a.pricePerNight));
    }
    return sortedRooms;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              CustomFilterButton(
                label: 'ทั้งหมด',
                icon: Icons.apps,
                isSelected: _selectedGuestFilter == 'ทั้งหมด',
                onTap: () => _onRoomGuestChanged('ทั้งหมด'),
              ),
              CustomFilterButton(
                label: '1-2 คน',
                icon: Icons.person,
                isSelected: _selectedGuestFilter == '1-2',
                onTap: () => _onRoomGuestChanged('1-2'),
              ),
              CustomFilterButton(
                label: '3-4 คน',
                icon: Icons.people,
                isSelected: _selectedGuestFilter == '3-4',
                onTap: () => _onRoomGuestChanged('3-4'),
              ),
              CustomFilterButton(
                label: '5-8 คน',
                icon: Icons.groups,
                isSelected: _selectedGuestFilter == '5-8',
                onTap: () => _onRoomGuestChanged('5-8'),
              ),
              CustomFilterButton(
                label: '9+ คน',
                icon: Icons.groups_3,
                isSelected: _selectedGuestFilter == '9+',
                onTap: () => _onRoomGuestChanged('9+'),
              ),
            ],
          ),
        ),

        BlocBuilder<RoomSearchBloc, RoomSearchState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ทั้งหมด ${state.rooms.length} รายการ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontFamily: 'NotoSansThai',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SortDropdown(
                    selectedSort: _selectedSort,
                    sortOptions: _roomSortOptions,
                    onSortChanged: _onSortChanged,
                  ),
                ],
              ),
            );
          },
        ),

        Expanded(
          child: BlocBuilder<RoomSearchBloc, RoomSearchState>(
            builder: (context, state) {
              switch (state.status) {
                case RoomSearchStatus.initial:
                case RoomSearchStatus.loading:
                  return const LoadingState(
                    message: 'กำลังโหลดข้อมูล...',
                  );

                case RoomSearchStatus.failure:
                  return ErrorState(
                    title: 'เกิดข้อผิดพลาด',
                    message: state.errorMessage,
                    onRetry: () {
                      context.read<RoomSearchBloc>().add(const SearchRooms());
                    },
                  );

                case RoomSearchStatus.success:
                  if (state.rooms.isEmpty) {
                    return NotFoundSearch();
                  }

                  final sortedRooms = _applySorting(state.rooms);

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<RoomSearchBloc>().add(SearchRooms());
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                        bottom: 90,
                      ),
                      itemCount: sortedRooms.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final room = sortedRooms[index];
                        return ItemCard(
                          roomName: room.name,
                          price: room.pricePerNight.toStringAsFixed(0),
                          imagePath: 'assets/picture/room/image.png',
                          color: Colors.white,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        RoomDetailPage(roomId: room.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}
