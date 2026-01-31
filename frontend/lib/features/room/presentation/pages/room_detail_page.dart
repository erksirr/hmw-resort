// features/rooms/presentation/pages/room_detail_page.dart
import 'package:flutter/material.dart';

class RoomDetailPage extends StatefulWidget {
  final String roomId;
  
  const RoomDetailPage({super.key, required this.roomId});

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guests = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: PageView(
                children: [
                  // Image.network('room1.jpg', fit: BoxFit.cover),
                  // Image.network('room2.jpg', fit: BoxFit.cover),
                  // Image.network('room3.jpg', fit: BoxFit.cover),
                ],
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Deluxe Room',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'ห้องหรูพร้อมวิวสวนสวย',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          Text(
                            '4.8',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(' (128)', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '฿2,000',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text('ต่อคืน', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        Chip(
                          label: Text('ลด 20%'),
                          backgroundColor: Colors.red,
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  Text(
                    'ข้อมูลห้องพัก',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      _infoChip(Icons.square_foot, '32 ตร.ม.'),
                      SizedBox(width: 12),
                      _infoChip(Icons.bed, 'King Bed'),
                      SizedBox(width: 12),
                      _infoChip(Icons.people, '2 คน'),
                    ],
                  ),
                  
                  SizedBox(height: 24),
                  
                  Text(
                    'สิ่งอำนวยความสะดวก',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _amenityChip(Icons.wifi, 'WiFi ฟรี'),
                      _amenityChip(Icons.ac_unit, 'เครื่องปรับอากาศ'),
                      _amenityChip(Icons.tv, 'Smart TV'),
                      _amenityChip(Icons.bathtub, 'อ่างอาบน้ำ'),
                      _amenityChip(Icons.coffee, 'เครื่องชงกาแฟ'),
                      _amenityChip(Icons.balcony, 'ระเบียง'),
                    ],
                  ),
                  
                  SizedBox(height: 24),
                  
                  Text(
                    'รายละเอียด',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ห้องพักสไตล์โมเดิร์นพร้อมวิวสวนสวย ติดตั้งเครื่องปรับอากาศ เตียงคิงไซส์ พร้อมห้องน้ำในตัวที่มีอ่างอาบน้ำ และอุปกรณ์อำนวยความสะดวกครบครัน',
                    style: TextStyle(height: 1.5),
                  ),
                  
                  SizedBox(height: 24),
                  
                  Text(
                    'จองห้องพัก',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _dateSelector(
                          'เช็คอิน',
                          _checkInDate,
                          () => _selectDate(true),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _dateSelector(
                          'เช็คเอาท์',
                          _checkOutDate,
                          () => _selectDate(false),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 12),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('จำนวนผู้เข้าพัก'),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                if (_guests > 1) {
                                  setState(() => _guests--);
                                }
                              },
                            ),
                            Text('$_guests', style: TextStyle(fontSize: 18)),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() => _guests++);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
  
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'จองเลย',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
  
  Widget _amenityChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      backgroundColor: Colors.grey.shade100,
    );
  }
  
  Widget _dateSelector(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 4),
            Text(
              date != null 
                  ? '${date.day}/${date.month}/${date.year}'
                  : 'เลือกวันที่',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _selectDate(bool isCheckIn) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    
    if (date != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = date;
        } else {
          _checkOutDate = date;
        }
      });
    }
  }
}