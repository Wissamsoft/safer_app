import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/route_transitions.dart';
import 'onboarding_screen.dart';
import '../core/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context)
            .pushReplacement(createFadeRoute(const OnboardingScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF14142B), Color(0xFF4B3CDE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // use Lottie network animation with fallback
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Lottie.network(
                'https://assets2.lottiefiles.com/packages/lf20_jcikwtux.json',
                fit: BoxFit.contain,
                repeat: false,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.flight,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.18,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'انقطع الاتصال',
              style: TextStyle(
                color: Colors.white,
                fontSize: rs(context, 22),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.0),
              child: Text(
                'يبدو أنك خارج نطاق تغطية الشبكة الآن. سنحاول إعادة الاتصال تلقائيًا عند توفر الشبكة.',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
