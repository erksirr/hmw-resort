import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/search/presentation/models/sort_option.dart';

class SortDropdown extends StatelessWidget {
  final String selectedSort;
  final Function(String) onSortChanged;
  final List<SortOption> sortOptions;

  const SortDropdown({
    super.key,
    required this.selectedSort,
    required this.onSortChanged,
    required this.sortOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sort,
            size: 16,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 6),
          DropdownButton<String>(
            value: selectedSort,
            underline: const SizedBox(),
            isDense: true,
            icon: Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            style: TextStyle(
              fontFamily: 'NotoSansThai',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            elevation: 8,
            items: sortOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option.value,
                child: Text(
                  option.label
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onSortChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
