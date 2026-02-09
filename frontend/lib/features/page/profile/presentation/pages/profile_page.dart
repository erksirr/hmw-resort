// features/profile/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/page/auth/presentation/pages/login_page.dart';
import 'package:hemawan_resort/shared/widgets/layout/app_scaffold.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    void _logout() {
      setState(() => _isLoading = true);

      // Implement actual login API call
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginPage()),
          );
        }
      });
    }

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
            Text('John Doe', style: textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'john@email.com',
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 32),

            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text('ตั้งค่า', style: textTheme.bodyLarge),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('ออกจากระบบ', style: textTheme.bodyLarge),
              onTap: _isLoading ? null : _logout,
            ),
          ],
        ),
      ),
    );
  }
}
