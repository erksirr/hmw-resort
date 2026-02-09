import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/page/home/presentation/widgets/body/type_button.dart';
import 'package:hemawan_resort/shared/widgets/cards/item_card.dart';

class RecommendCard extends StatefulWidget {
  final double? height;
  const RecommendCard({super.key,required this.height});

  @override
  State<RecommendCard> createState() => _RecommendCardState();
}

class _RecommendCardState extends State<RecommendCard> {
  String selectedType = 'ห้องพัก';
  final rooms = [
    {'name': 'Garden View Room', 'price': '2,500 THB / night'},
    {'name': 'Sea View Room', 'price': '3,200 THB / night'},
    {'name': 'พูลวิลล่า', 'price': '5,900 THB / night'},
  ];
  @override
  Widget build(BuildContext context) {
   final double cardHeight = (widget.height ?? 500) - 175;
    return Positioned(
      top: 160,
      left: 15,
      right: 15,
      child: Container(
        height: cardHeight,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'รายการแนะนำ',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TypeButton(
                  selectedType: selectedType,
                  onTypeChanged: (type) {
                    setState(() {
                      selectedType = type;
                    });
                  },
                  type: 'ห้องพัก',
                ),
                const SizedBox(width: 10),
                TypeButton(
                  selectedType: selectedType,
                  onTypeChanged: (type) {
                    setState(() {
                      selectedType = type;
                    });
                  },
                  type: 'กิจกรรม',
                ),
                const SizedBox(width: 10),
                TypeButton(
                  selectedType: selectedType,
                  onTypeChanged: (type) {
                    setState(() {
                      selectedType = type;
                    });
                  },
                  type: 'อาหาร',
                ),
              ],
            ),
            SizedBox(height: 20),
            // DetailCard(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: rooms.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return ItemCard(
                    roomName: room['name']!,
                    price: room['price']!,
                    imagePath: 'assets/picture/room/image.png',
                    color: Color.fromARGB(203, 245, 245, 245),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
