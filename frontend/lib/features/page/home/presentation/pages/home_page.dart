import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/page/home/presentation/widgets/appbar/top_background.dart';
import 'package:hemawan_resort/features/page/home/presentation/widgets/body/banner_card.dart';
import 'package:hemawan_resort/features/page/home/presentation/widgets/body/promotion_card.dart';
import 'package:hemawan_resort/features/page/home/presentation/widgets/body/recommend_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double? height = 700;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height,
              child: Stack(children: [TopBackground(), RecommendCard(height: height) ]),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  PromotionCard(),
                  SizedBox(height: 20),
                  BannerCard(
                    imagePath: 'assets/picture/room/image.png',
                    title: 'ยินดีต้อนรับทุกท่าน !',
                    subtitle: 'เกี่ยวกับเรา',
                  ),
                  SizedBox(height: 20),
                  BannerCard(
                    title: 'จองตอนนี้ !',
                    subtitle: 'รับส่วนลดพิเศษ',
                    backgroundColor: Colors.green.shade400,
                  ),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
