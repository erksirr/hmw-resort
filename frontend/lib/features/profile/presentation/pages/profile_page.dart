// features/profile/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:hemawan_resort/shared/widgets/layout/app_scaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      title: 'โปรไฟล์',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              'John Doe',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'john@email.com',
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 32),

            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text(
                'ตั้งค่า',
                style: textTheme.bodyLarge,
              ),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'Logout',
                style: textTheme.bodyLarge,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
