// features/search/presentation/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/search/presentation/pages/body_search_page.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/appbar/top_background_search.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/appbar/search_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _minPrice = 0;
  int _maxPrice = 10000;
  double _rating = 0;

  void _onFilterApplied(int minPrice, int maxPrice, double rating) {
    setState(() {
      _minPrice = minPrice;
      _maxPrice = maxPrice;
      _rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 210,
              child: Stack(
                children: [
                  TopBackgroundSearch(),
                  SearchField(onFilterApplied: _onFilterApplied),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height - 210,
              child: BodySearchPage(
                minPrice: _minPrice,
                maxPrice: _maxPrice,
                rating: _rating,
              ),
            ),
          ],
        ),
      ),
    );
  }
}