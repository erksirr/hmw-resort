import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;
  final String type;
  const TypeButton({
    Key? key,
    required this.selectedType,
    required this.onTypeChanged,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTypeChanged(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color:
                isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
