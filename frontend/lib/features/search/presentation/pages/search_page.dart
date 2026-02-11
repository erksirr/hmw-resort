// features/search/presentation/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hemawan_resort/features/room/data/models/req/room_search_params.dart';
import 'package:hemawan_resort/features/room/data/repositories/room_repository.dart';
import 'package:hemawan_resort/features/room/presentation/bloc/room_search/room_search_bloc.dart';
import 'package:hemawan_resort/features/room/presentation/bloc/room_search/room_search_event.dart';
import 'package:hemawan_resort/features/search/presentation/pages/body_search_page.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/appbar/top_background_search.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/appbar/search_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomSearchBloc(
        repository: RoomRepository(client: http.Client()),
      )..add(const SearchRooms()),
      child: const _SearchPageContent(),
    );
  }
}

class _SearchPageContent extends StatefulWidget {
  const _SearchPageContent();

  @override
  State<_SearchPageContent> createState() => _SearchPageContentState();
}

class _SearchPageContentState extends State<_SearchPageContent> {
  String _query = '';
  int _minPrice = 0;
  int _maxPrice = 10000;
  double _rating = 0;

  
  void _onFilterApplied(String query, int minPrice, int maxPrice, double rating) {
    print('Filter Applied: query=$query, minPrice=$minPrice, maxPrice=$maxPrice, rating=$rating');
    setState(() {
      _query = query;
      _minPrice = minPrice;
      _maxPrice = maxPrice;
      _rating = rating;
    });

    final params = RoomSearchParams(
      query: query.isNotEmpty ? query : null,
      minPrice: minPrice.toDouble(),
      maxPrice: maxPrice.toDouble(),
      rating: rating > 0 ? rating : null,
    );
    context.read<RoomSearchBloc>().add(SearchRooms(params));
  }

  void _onSearchChanged(String query) {
    setState(() {
      _query = query;
    });

    final params = RoomSearchParams(
      query: query.isNotEmpty ? query : null,
      minPrice: _minPrice.toDouble(),
      maxPrice: _maxPrice.toDouble(),
      rating: _rating > 0 ? _rating : null,
    );
    context.read<RoomSearchBloc>().add(SearchRooms(params));
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
                  SearchField(
                    onFilterApplied: _onFilterApplied,
                    onSearchChanged: _onSearchChanged,
                  ),
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