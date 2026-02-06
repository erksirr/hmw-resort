import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? message;
  final VoidCallback? onAction;
  final String? actionText;

  const EmptyState({
    super.key,
    this.icon,
    this.title,
    this.message,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              title ?? 'ไม่พบข้อมูล',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontFamily: 'NotoSansThai',
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
            if (message != null && message!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: 'NotoSansThai',
                      color: Colors.grey,
                    ),
              ),
            ],
            if (onAction != null && actionText != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                child: Text(
                  actionText!,
                  style: const TextStyle(fontFamily: 'NotoSansThai'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
