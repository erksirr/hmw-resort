import 'package:flutter/material.dart';
import 'package:hemawan_resort/core/utils/text_utils.dart';

class ItemCard extends StatelessWidget {
  final String roomName;
  final String price;
  final String? imageUrl;   
  final String? imagePath;  
  final VoidCallback onTap;
  final Color? color;

  const ItemCard({
    super.key,
    required this.roomName,
    required this.price,
    required this.onTap,
    this.imageUrl,
    this.imagePath,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Container สำหรับรูปภาพ
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green.shade100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildImage(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontFamily:
                          roomName.isEnglish ? 'Lexend' : 'NotoSansThai',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontFamily:
                          price.isEnglish ? 'Lexend' : 'NotoSansThai',
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'View Details →',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontFamily: 'Lexend',
                      color: const Color(0xFF2F5D50),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }
    
    if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }
    
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.green.shade100,
      child: Center(
        child: Icon(
          Icons.image_not_supported,
          size: 40,
          color: Colors.green.shade300,
        ),
      ),
    );
  }
}