import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/search/presentation/widgets/appbar/search_filter_popup.dart';

class SearchField extends StatelessWidget {
  final void Function(int minPrice, int maxPrice, double rating)? onFilterApplied;

  const SearchField({super.key, this.onFilterApplied});

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

    if (result != null && onFilterApplied != null) {
      onFilterApplied!(
        result['minPrice'] as int,
        result['maxPrice'] as int,
        result['rating'] as double,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 135,
      left: 16,
      right: 16,
      child: TextField(
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
