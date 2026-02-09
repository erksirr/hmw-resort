import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchFilterPopup extends StatefulWidget {
  const SearchFilterPopup({super.key});

  @override
  State<SearchFilterPopup> createState() => _SearchFilterPopupState();
}

class _SearchFilterPopupState extends State<SearchFilterPopup> {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
    double _minRating = 0;

  @override
  void initState() {
    super.initState();
    _minPriceController.text = '0';
    _maxPriceController.text = '10000';
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(top: 24,right: 24,left: 24,bottom: 48 ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ตัวกรอง',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansThai',
                    ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  setState(() {
                    _minPriceController.text = '0';
                    _maxPriceController.text = '10000';
                    _minRating = 0;
                  });
                },
                child: Text(
                  'รีเซ็ต',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontFamily: 'NotoSansThai',
                        color:Colors.white,
                      ),
                ),
              ),
            ],
          ),
           SizedBox(height: 16),
          // Price Range
          Text(
            'ช่วงราคา',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'NotoSansThai',
                ),
          ),
           SizedBox(height: 16),
          
          Row(
            children: [
              // Min Price
              Expanded(
                child: TextField(
                  controller: _minPriceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    labelText: 'ราคาต่ำสุด',
                    labelStyle: const TextStyle(fontFamily: 'NotoSansThai'),
                    prefixText: '฿ ',
                    prefixStyle: const TextStyle(fontFamily: 'Lexend'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: const TextStyle(fontFamily: 'Lexend'),
                ),
              ),
              SizedBox(width: 24),
              
              // Max Price
              Expanded(
                child: TextField(
                  controller: _maxPriceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    labelText: 'ราคาสูงสุด',
                    labelStyle: const TextStyle(fontFamily: 'NotoSansThai'),
                    prefixText: '฿ ',
                    prefixStyle: const TextStyle(fontFamily: 'Lexend'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: const TextStyle(fontFamily: 'Lexend'),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            'คะแนนขั้นต่ำ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'NotoSansThai',
                ),
          ),
          SizedBox(height: 16),

          // Rating Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ratingButton('ทั้งหมด', 0, null),
              _ratingButton('3+', 3, 3),
              _ratingButton('4+', 4, 4),
              _ratingButton('4.5+', 4.5, 5),
            ],
          ),
          const SizedBox(height: 32),
          // Apply Button
          Center(
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Validate
                  final minPrice = int.tryParse(_minPriceController.text) ?? 0;
                  final maxPrice = int.tryParse(_maxPriceController.text) ?? 10000;
                  
                  if (minPrice > maxPrice) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'ราคาต่ำสุดต้องน้อยกว่าราคาสูงสุด',
                          style: TextStyle(fontFamily: 'NotoSansThai'),
                        ),
                      ),
                    );
                    return;
                  }
                  
                  // Return filter values
                  Navigator.pop(context, {
                    'minPrice': minPrice,
                    'maxPrice': maxPrice,
                    'rating': _minRating,
                  });
                },
               style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'กรอง',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontFamily: 'NotoSansThai',
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _ratingButton(String label, double rating, int? starCount) {
    final isSelected = _minRating == rating;
    return InkWell(
      onTap: () => setState(() => _minRating = rating),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 70,
        width: 70,
        padding: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.2)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
                fontFamily: label == 'ทั้งหมด' ? 'NotoSansThai' : 'Lexend',
                fontSize: 14,
              ),
            ),
            if (starCount != null) ...[
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  starCount,
                  (index) => Icon(
                    Icons.star,
                    size: 12,
                    color: isSelected ? Colors.amber : Colors.grey[400],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}