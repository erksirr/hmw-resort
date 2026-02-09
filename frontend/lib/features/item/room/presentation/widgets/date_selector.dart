import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback? onTap;
  const DateSelector({super.key, required this.label, required this.date,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey, fontFamily: 'NotoSansThai'),
            ),
            const SizedBox(height: 4),
            Text(
              date != null
                  ? '${date!.day}/${date!.month}/${date!.year}'
                  : 'เลือกวันที่',
              style: TextStyle(
                fontSize: 16,
                fontFamily: date != null ? 'Lexend' : 'NotoSansThai',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
