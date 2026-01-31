import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/home/presentation/pages/home_page.dart';
import 'package:hemawan_resort/features/booking/presentation/pages/booking_page.dart';
import 'package:hemawan_resort/features/profile/presentation/pages/profile_page.dart';
import 'package:hemawan_resort/features/search/presentation/pages/search_page.dart';
import 'package:hemawan_resort/features/more/presentation/pages/more_page.dart';
import 'package:hemawan_resort/injection_dart.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  final _pages = const [
    HomePage(),
    SearchPage(),
    BookingPage(),
    MorePage(),
    // InjectionDart(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'ค้นหา',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'รายการจอง',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_service_outlined),
            label: 'บริการ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'โปรไฟล์',
          ),
        ],
      ),
    );
  }
}
