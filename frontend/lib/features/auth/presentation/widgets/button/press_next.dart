import 'package:flutter/material.dart';

class PressNext extends StatelessWidget {
  final VoidCallback onTap;
  const PressNext({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor),
        onPressed: onTap,
      ),
    );
  }
}
