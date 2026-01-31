// features/more/presentation/pages/more_page.dart
import 'package:flutter/material.dart';
import 'package:hemawan_resort/shared/widgets/layout/app_scaffold.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'บริการ',
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
           ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('รายละเอียดต่างๆ'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: Text('ช่องทางการติดต่อ'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: Text('รีวิว'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
