import 'package:flutter/material.dart';
import 'package:hemawan_resort/shared/widgets/cards/item_card.dart';
import 'package:hemawan_resort/features/page/search/presentation/models/sort_option.dart';
import 'package:hemawan_resort/features/page/search/presentation/widgets/body/not_found_search.dart';
import 'package:hemawan_resort/features/page/search/presentation/widgets/body/sort_dropdown.dart';
import 'package:hemawan_resort/features/page/search/presentation/widgets/body/custom_filter_button.dart';

class FoodItemPage extends StatefulWidget {
  const FoodItemPage({super.key});

  @override
  State<FoodItemPage> createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  String _selectedFoodType = 'ทั้งหมด';
  String _selectedSort = 'newest';

  List<Map<String, dynamic>> _filteredFoods = [];

  @override
  void initState() {
    super.initState();
    _updateFilteredFoods();
  }

  void _updateFilteredFoods() {
    List<Map<String, dynamic>> filtered;

    // Filter by food type
    if (_selectedFoodType == 'ทั้งหมด') {
      filtered = List.from(_allFoods);
    } else {
      filtered =
          _allFoods.where((food) => food['type'] == _selectedFoodType).toList();
    }

    // Apply sorting
    _applySorting(filtered);
    _filteredFoods = filtered;
  }

  void _onFoodTypeChanged(String newType) {
    setState(() {
      _selectedFoodType = newType;
      _updateFilteredFoods();
    });
  }

  void _onSortChanged(String newSort) {
    setState(() {
      _selectedSort = newSort;
      _updateFilteredFoods();
    });
  }

  static const List<SortOption> _foodSortOptions = [
    SortOption(value: 'newest', label: 'ใหม่ล่าสุด'),
    SortOption(value: 'price_asc', label: 'ราคา: ต่ำ-สูง'),
    SortOption(value: 'price_desc', label: 'ราคา: สูง-ต่ำ'),
    SortOption(value: 'rating', label: 'คะแนนสูงสุด'),
  ];
  final List<Map<String, dynamic>> _allFoods = [
    {
      'name': 'บุฟเฟ่ต์อาหารเช้า',
      'price': '450 THB / person',
      'type': 'อาหารเช้า',
      'image': 'assets/picture/food/breakfast.png',
    },
    {
      'name': 'อาหารทะเล',
      'price': '1,500 THB / set',
      'type': 'อาหารเช้า',
      'image': 'assets/picture/food/seafood.png',
    },
    {
      'name': 'BBQ ริมชายหาด',
      'price': '2,000 THB / set',
      'type': 'อาหารเย็น',
      'image': 'assets/picture/food/bbq.png',
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
        // Filter: ประเภทอาหาร
        Container(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              CustomFilterButton(
                label: 'ทั้งหมด',
                icon: Icons.restaurant,
                isSelected: _selectedFoodType == 'ทั้งหมด',
                onTap: () => _onFoodTypeChanged('ทั้งหมด'),
              ),
              CustomFilterButton(
                label: 'อาหารเช้า',
                icon: Icons.free_breakfast,
                isSelected: _selectedFoodType == 'อาหารเช้า',
                onTap: () => _onFoodTypeChanged('อาหารเช้า'),
              ),
              CustomFilterButton(
                label: 'อาหารกลางวัน',
                icon: Icons.lunch_dining,
                isSelected: _selectedFoodType == 'อาหารกลางวัน',
                onTap: () => _onFoodTypeChanged('อาหารกลางวัน'),
              ),
              CustomFilterButton(
                label: 'อาหารเย็น',
                icon: Icons.dinner_dining,
                isSelected: _selectedFoodType == 'อาหารเย็น',
                onTap: () => _onFoodTypeChanged('อาหารเย็น'),
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
                'ทั้งหมด ${_filteredFoods.length} เมนู',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: 'NotoSansThai',
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Sort dropdown
              SortDropdown(
                selectedSort: _selectedSort,
                sortOptions: _foodSortOptions,
                onSortChanged: _onSortChanged,
              ),
            ],
          ),
        ),

        // Food List
        Expanded(
          child:
              _filteredFoods.isEmpty
                  ?  NotFoundSearch()
                  : ListView.separated(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 90,
                    ),
                    itemCount: _filteredFoods.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final food = _filteredFoods[index];
                      return ItemCard(
                        roomName: food['name']!,
                        price: food['price']!,
                        imagePath: food['image'],
                        color: Colors.white,
                        onTap: () {
                          
                        },
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
