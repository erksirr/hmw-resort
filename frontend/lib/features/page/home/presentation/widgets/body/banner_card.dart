import 'package:flutter/material.dart';
import 'package:hemawan_resort/core/utils/text_utils.dart';

class BannerCard extends StatelessWidget {
  final String? imageUrl; 
  final String? imagePath;
  final String title;
  final String? subtitle;
  final Color? backgroundColor;
  final double height;

  const BannerCard({
    super.key,
    this.imageUrl,
    this.imagePath,
    required this.title,
    this.subtitle,
    this.backgroundColor,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        // เพิ่มรูปภาพเป็น background
        image: _buildBackgroundImage(),
      ),
      child: Container(
        // เพิ่ม gradient overlay เพื่อให้ text อ่านง่าย
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily:title.isEnglish ? 'Lexend' : 'NotoSansThai',
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 10),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              const Icon(
                Icons.beach_access,
                size: 30,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DecorationImage? _buildBackgroundImage() {
    if (imageUrl != null) {
      return DecorationImage(
        image: NetworkImage(imageUrl!),
        fit: BoxFit.cover,
      );
    } else if (imagePath != null) {
      return DecorationImage(
        image: AssetImage(imagePath!),
        fit: BoxFit.cover,
      );
    }
    return null;
  }
}