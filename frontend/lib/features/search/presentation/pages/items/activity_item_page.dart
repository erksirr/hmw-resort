import 'package:flutter/material.dart';
import 'package:hemawan_resort/shared/widgets/cards/item_card.dart';
import 'package:hemawan_resort/features/search/presentation/models/sort_option.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/body/custom_filter_button.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/body/not_found_search.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/body/sort_dropdown.dart';

class ActivityItemPage extends StatefulWidget {
  const ActivityItemPage({super.key});

  @override
  State<ActivityItemPage> createState() => _ActivityItemPageState();
}

class _ActivityItemPageState extends State<ActivityItemPage> {
  String _selectedActivityType = 'ทั้งหมด';
  String _selectedSort = 'newest';
  List<Map<String, dynamic>> _filteredActivities = [];
  @override
  void initState() {
    super.initState();
    _updateFilteredActivities();
  }

  void _updateFilteredActivities() {
    List<Map<String, dynamic>> filtered;
    if (_selectedActivityType == 'ทั้งหมด') {
      filtered = List.from(_allActivities);
    } else {
      filtered =
          _allActivities.where((food) => food['type'] == _selectedActivityType).toList();
    }
    // Apply sorting
    _applySorting(filtered);
    _filteredActivities = filtered;
  }

  void _onActivityTypeChanged(String newType) {
    setState(() {
      _selectedActivityType = newType;
      _updateFilteredActivities();
    });
  }

  void _onSortChanged(String newSort) {
    setState(() {
      _selectedSort = newSort;
      _updateFilteredActivities();
    });
  }

  // Sort Options
  static const List<SortOption> _activitySortOptions = [
    SortOption(value: 'newest', label: 'ใหม่ล่าสุด'),
    SortOption(value: 'price_asc', label: 'ราคา: ต่ำ-สูง'),
    SortOption(value: 'price_desc', label: 'ราคา: สูง-ต่ำ'),
    SortOption(value: 'rating', label: 'คะแนนสูงสุด'),
  ];

  final List<Map<String, dynamic>> _allActivities = [
    {
      'name': 'ดำน้ำดูปะการัง',
      'price': '1,200 THB / person',
      'type': 'กลางแจ้ง',
      'image': 'assets/picture/activity/diving.png',
    },
    {
      'name': 'นวดสปา',
      'price': '800 THB / hour',
      'type': 'ในร่ม',
      'image': 'assets/picture/activity/spa.png',
    },
    {
      'name': 'ล่องเรือชมพระอาทิตย์ตก',
      'price': '1,500 THB / person',
      'type': 'กลางแจ้ง',
      'image': 'assets/picture/activity/sunset.png',
    },
  ];

  void _applySorting(List<Map<String, dynamic>> foods) {
    switch (_selectedSort) {
      case 'price_asc':
        foods.sort((a, b) {
          final priceA = _extractPrice(a['price']);
          final priceB = _extractPrice(b['price']);
          return priceA.compareTo(priceB);
        });
        break;
      case 'price_desc':
        foods.sort((a, b) {
          final priceA = _extractPrice(a['price']);
          final priceB = _extractPrice(b['price']);
          return priceB.compareTo(priceA);
        });
        break;
      case 'rating':
        foods.sort((a, b) {
          final ratingA = a['rating'] ?? 0.0;
          final ratingB = b['rating'] ?? 0.0;
          return ratingB.compareTo(ratingA);
        });
        break;
      case 'newest':
        foods.sort((a, b) {
          final dateA = a['created_at'] ?? '';
          final dateB = b['created_at'] ?? '';
          return dateB.compareTo(dateA);
        });
        break;
    }
  }
  int _extractPrice(String priceString) {
    return int.parse(priceString.replaceAll(RegExp(r'[^0-9]'), ''));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter: ประเภทกิจกรรม
        Container(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              CustomFilterButton(
                label: 'ทั้งหมด',
                icon: Icons.local_activity,
                isSelected: _selectedActivityType == 'ทั้งหมด',
                onTap: () => _onActivityTypeChanged('ทั้งหมด')
              ),
              CustomFilterButton(
                label: 'กลางแจ้ง',
                icon: Icons.wb_sunny,
                isSelected: _selectedActivityType == 'กลางแจ้ง',
                onTap: () => _onActivityTypeChanged('กลางแจ้ง')
              ),
              CustomFilterButton(
                label: 'ในร่ม',
                icon: Icons.meeting_room,
                isSelected: _selectedActivityType == 'ในร่ม',
                onTap: () => _onActivityTypeChanged('ในร่ม')
              ),
              CustomFilterButton(
                label: 'ผจญภัย',
                icon: Icons.hiking,
                isSelected: _selectedActivityType == 'ผจญภัย',
                onTap: () => _onActivityTypeChanged('ผจญภัย')
              ),
            ],
          ),
        ),

        // Result Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ทั้งหมด ${_filteredActivities.length} รายการ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: 'NotoSansThai',
                  fontWeight: FontWeight.w600,
                ),
              ),

              // Sort Dropdown Component
              SortDropdown(
                selectedSort: _selectedSort,
                sortOptions: _activitySortOptions,
                onSortChanged: _onSortChanged,
              ),
            ],
          ),
        ),

        // Activity List
        Expanded(
          child:
              _filteredActivities.isEmpty
                  ? NotFoundSearch()
                  : ListView.separated(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 90,
                    ),
                    itemCount: _filteredActivities.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final activity = _filteredActivities[index];
                      return ItemCard(
                        roomName: activity['name']!,
                        price: activity['price']!,
                        imagePath: activity['image'],
                        color: Colors.white,
                        onTap: () {},
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
