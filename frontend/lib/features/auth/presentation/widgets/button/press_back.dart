import 'package:flutter/material.dart';

class PressBack extends StatelessWidget {
  final VoidCallback onTap;
  const PressBack({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }
}
