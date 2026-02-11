import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/auth/presentation/pages/login_page.dart';
import 'package:hemawan_resort/features/auth/presentation/pages/register_page.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/press_back.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/press_next.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/skip_button.dart';

class _OnboardingData {
  final IconData icon;
  final String headline;
  final String description;

  const _OnboardingData({
    required this.icon,
    required this.headline,
    required this.description,
  });
}

const _slides = [
  _OnboardingData(
    icon: Icons.villa,
    headline: 'Hemawan Resort',
    description: 'พักผ่อนอย่างเหนือระดับ\nท่ามกลางธรรมชาติที่สวยงาม',
  ),
  _OnboardingData(
    icon: Icons.hotel,
    headline: 'ห้องพักหลากสไตล์',
    description: 'เลือกห้องพักที่ใช่สำหรับคุณ\nพร้อมราคาพิเศษสำหรับสมาชิก',
  ),
  _OnboardingData(
    icon: Icons.restaurant,
    headline: 'อาหารชั้นเลิศ',
    description: 'เพลิดเพลินกับเมนูอาหาร\nจากเชฟมืออาชีพของเรา',
  ),
  _OnboardingData(
    icon: Icons.calendar_month,
    headline: 'จองง่าย ใน 3 ขั้นตอน',
    description: 'เลือกห้อง กดจอง เช็คอิน\nไม่ต้องรอนาน เริ่มต้นเลย!',
  ),
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  int _currentPage = 0;

  bool get _isLastPage => _currentPage == _slides.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  void _skipToLogin() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: Text(
              'ข้ามไปหน้าเข้าสู่ระบบ?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              'คุณต้องการข้ามการแนะนำและไปหน้าเข้าสู่ระบบเลยใช่ไหม?',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'ยกเลิก',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.of(this.context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                child: Text(
                  'ใช่, ไปเลย',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _nextPage() {
    if (_isLastPage) return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              _currentPage > 0
                  ? // Hide on last page and first page
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, left: 24),
                      child: PressBack(
                        onTap: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  )
                  : SizedBox(height: 48),

              // Slides per 1
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return _buildSlide(slide);
                  },
                ),
              ),

              // Dots indicator
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _slides.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),

              // Back / Next row (แสดงตลอด)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button (ซ่อนเฉพาะหน้าแรก)
                    _currentPage > 0 && !_isLastPage
                        ? SkipButton(onTap: _skipToLogin)
                        : SizedBox.shrink(),
                    // Next button (ซ่อนในหน้าสุดท้าย)
                    !_isLastPage
                        ? PressNext(onTap: _nextPage)
                        : SizedBox.shrink(),
                  ],
                ),
              ),

              // Last Page Get Started Button
              if (_isLastPage)
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _goToLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:  Text(
                            'เริ่มต้นใช้งาน',
                           style:Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).primaryColor,
                             
                          ),
                        ),
                      ),
                      )
                    ],
                  ),
                ),

              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(_OnboardingData slide) {
    final isFirst = slide == _slides.first;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(slide.icon, size: 72, color: Colors.white),
          ),
          SizedBox(height: 40),
          Text(
            slide.headline,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isFirst ? 36 : 28,
              fontWeight: FontWeight.bold,
              fontFamily: isFirst ? 'Lexend' : 'NotoSansThai',
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansThai',
              color: Colors.white70,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
