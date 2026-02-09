import 'package:flutter/material.dart';

class BorderForIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;

  const BorderForIcon({
    super.key,
    this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        padding: EdgeInsets.all(12),
      ),
    );
  }
}
