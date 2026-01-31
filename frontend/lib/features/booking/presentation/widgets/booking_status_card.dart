import 'package:flutter/material.dart';
import 'package:hemawan_resort/core/utils/text_utils.dart';

class BookingStatusCard extends StatelessWidget {
  final String roomName;
  final String checkInDate;
  final String checkOutDate;
  final BookingStatus status;
  final VoidCallback? onTap;

  const BookingStatusCard({
    super.key,
    required this.roomName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    roomName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily:
                              roomName.isEnglish ? 'Lexend' : 'NotoSansThai',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                _buildStatusChip(context),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  '$checkInDate - $checkOutDate',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontFamily: 'Lexend',
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (status) {
      case BookingStatus.confirmed:
        backgroundColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        statusText = 'ยืนยันแล้ว';
        break;
      case BookingStatus.pending:
        backgroundColor = Colors.orange.shade50;
        textColor = Colors.orange.shade700;
        statusText = 'รอยืนยัน';
        break;
      case BookingStatus.cancelled:
        backgroundColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        statusText = 'ยกเลิกแล้ว';
        break;
      case BookingStatus.completed:
        backgroundColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        statusText = 'เสร็จสิ้น';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'NotoSansThai',
        ),
      ),
    );
  }
}

enum BookingStatus {
  confirmed,
  pending,
  cancelled,
  completed,
}