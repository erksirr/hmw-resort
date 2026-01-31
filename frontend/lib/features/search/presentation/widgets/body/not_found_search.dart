import 'package:flutter/material.dart';

class NotFoundSearch extends StatelessWidget {
  const NotFoundSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'ไม่พบห้องพัก',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                fontFamily: 'NotoSansThai',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ลองเปลี่ยนตัวกรอง',
              style: TextStyle(
                color: Colors.grey[500],
                fontFamily: 'NotoSansThai',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
