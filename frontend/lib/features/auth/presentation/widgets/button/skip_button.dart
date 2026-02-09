import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback? onTap;
  const SkipButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text(
            'ข้าม',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansThai',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
