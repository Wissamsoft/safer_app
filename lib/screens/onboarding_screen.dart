import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/route_transitions.dart';
import 'home_screen.dart';
import '../core/responsive.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _page = 0;
  final PageController _controller = PageController();

  final _pages = [
    {
      'title': 'اكتشف العروض المميزة',
      'desc': 'تصفح أفضل رحلات النقل والمطاعم والخدمات القريبة منك.',
    },
    {
      'title': 'ادفع بسهولة',
      'desc': 'أضف بطاقاتك وادفع بأمان وسرعة عبر التطبيق.',
    },
    {
      'title': 'تابع رحلتك',
      'desc': 'اعرف موقع السائق وتوقيت الوصول بدقة.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context)
                .pushReplacement(createFadeRoute(const HomeScreen())),
            child: const Text('تخطي', style: TextStyle(color: Colors.black54)),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (v) => setState(() => _page = v),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final p = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.width * 0.6,
                          child: Lottie.network(
                            index == 0
                                ? 'https://assets6.lottiefiles.com/packages/lf20_5ngs2ksb.json'
                                : index == 1
                                    ? 'https://assets7.lottiefiles.com/packages/lf20_tzpj99.json'
                                    : 'https://assets8.lottiefiles.com/packages/lf20_cq8z6y.json',
                            fit: BoxFit.contain,
                            repeat: false,
                            errorBuilder: (ctx, err, st) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withAlpha((0.12 * 255).round())),
                              child: const Icon(Icons.travel_explore, size: 80),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(p['title']!,
                            style: TextStyle(
                                fontSize: rs(context, 22),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Text(p['desc']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) {
                final selected = i == _page;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: selected ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).primaryColor
                        : Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_page < _pages.length - 1) {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        } else {
                          Navigator.of(context).pushReplacement(
                              createFadeRoute(const HomeScreen()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        _page < _pages.length - 1 ? 'التالي' : 'ابدأ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: rs(context, 16)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
