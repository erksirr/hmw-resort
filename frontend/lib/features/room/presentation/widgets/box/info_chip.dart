import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const InfoChip({super.key,required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: label == "ไม่ว่าง" ? Colors.red.shade50 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: label == "ไม่ว่าง" ? Colors.red : Colors.blue,
          ),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontFamily: 'NotoSansThai')),
        ],
      ),
    );
  }
}