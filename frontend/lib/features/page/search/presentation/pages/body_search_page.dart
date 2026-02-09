import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/page/search/presentation/pages/items/activity_item_page.dart';
import 'package:hemawan_resort/features/page/search/presentation/pages/items/food_item_page.dart';
import 'package:hemawan_resort/features/page/search/presentation/pages/items/room_item_page.dart';

class BodySearchPage extends StatefulWidget {
  final int minPrice;
  final int maxPrice;
  final double rating;

  const BodySearchPage({
    super.key,
    this.minPrice = 0,
    this.maxPrice = 10000,
    this.rating = 0,
  });

  @override
  State<BodySearchPage> createState() => _BodySearchPageState();
}

class _BodySearchPageState extends State<BodySearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 3,
          tabs: [
            Tab(icon: Icon(Icons.hotel), text: 'ห้องพัก'),
            Tab(icon: Icon(Icons.restaurant_menu), text: 'อาหาร'),
            Tab(icon: Icon(Icons.local_activity), text: 'กิจกรรม'),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          child: TabBarView(
            controller: _tabController,
            children: [
              RoomItemPage(
                minPrice: widget.minPrice,
                maxPrice: widget.maxPrice,
                rating: widget.rating,
              ),
              FoodItemPage(),
              ActivityItemPage(),
            ],
          ),
        ),
      ],
    );
  }
}