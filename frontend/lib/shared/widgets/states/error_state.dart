import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;

  const ErrorState({super.key, this.title, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    print('ErrorState build with title: $title, message: $message');
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              title ?? 'เกิดข้อผิดพลาด',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontFamily: 'NotoSansThai',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(
                  "ลองใหม่",
                  style: const TextStyle(fontFamily: 'NotoSansThai'),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
