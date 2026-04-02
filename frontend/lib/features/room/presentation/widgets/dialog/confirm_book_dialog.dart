import 'package:flutter/material.dart';

Future<bool> showConfirmBookDialog(BuildContext context, String roomName) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'ยืนยันการจอง',
        style: TextStyle(fontFamily: 'NotoSansThai', fontWeight: FontWeight.bold),
      ),
      content: Text(
        'คุณต้องการจองห้อง "$roomName" ใช่หรือไม่?',
        style: const TextStyle(fontFamily: 'NotoSansThai'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'ยกเลิก',
            style: TextStyle(fontFamily: 'NotoSansThai', color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            'ยืนยัน',
            style: TextStyle(fontFamily: 'NotoSansThai'),
          ),
        ),
      ],
    ),
  );
  return result ?? false;
}