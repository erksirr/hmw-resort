// features/booking/presentation/pages/booking_page.dart
import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/booking/presentation/widgets/booking_status_card.dart';

import 'package:hemawan_resort/shared/widgets/layout/app_scaffold.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {

    final bookings = [
      {
        'roomName': 'Garden View Room',
        'checkIn': '12 Mar 2025',
        'checkOut': '14 Mar 2025',
        'status': BookingStatus.confirmed,
      },
      {
        'roomName': 'Sea View Room',
        'checkIn': '20 Mar 2025',
        'checkOut': '22 Mar 2025',
        'status': BookingStatus.pending,
      },
      {
        'roomName': 'พูลวิลล่า',
        'checkIn': '5 Apr 2025',
        'checkOut': '7 Apr 2025',
        'status': BookingStatus.confirmed,
      },
    ];

    return AppScaffold(
      title: 'รายการจอง',
      body:
          bookings.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 80, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Text(
                      'ไม่มีการจอง',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'คุณยังไม่มีการจองห้องพัก',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
              : ListView.separated(
                itemCount: bookings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return BookingStatusCard(
                    roomName: booking['roomName'] as String,
                    checkInDate: booking['checkIn'] as String,
                    checkOutDate: booking['checkOut'] as String,
                    status: booking['status'] as BookingStatus,
                    onTap: () {},
                  );
                },
              ),
    );
  }
}
