import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/page/search/presentation/widgets/appbar/search_filter_popup.dart';

class SearchField extends StatefulWidget {
  final void Function(String query, int minPrice, int maxPrice, double rating)? onFilterApplied;
  final void Function(String query)? onSearchChanged;

  const SearchField({super.key, this.onFilterApplied, this.onSearchChanged});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SearchFilterPopup();
      },
    );

    if (result != null && widget.onFilterApplied != null) {
      widget.onFilterApplied!(
        _searchController.text,
        result['minPrice'] as int,
        result['maxPrice'] as int,
        result['rating'] as double,
      );
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 300), () {
      if (widget.onSearchChanged != null) {
        widget.onSearchChanged!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 135,
      left: 16,
      right: 16,
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'ค้นหาสิ่งที่คุณต้องการ',
          hintStyle: TextStyle(
            fontFamily: 'NotoSansThai',
            color: Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune, color: Colors.grey),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
