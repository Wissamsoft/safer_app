import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.36,
              height: MediaQuery.of(context).size.width * 0.36,
              child: Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_jbrw3hcz.json',
                repeat: false,
                fit: BoxFit.contain,
                errorBuilder: (ctx, e, st) => Container(
                  width: MediaQuery.of(context).size.width * 0.28,
                  height: MediaQuery.of(context).size.width * 0.28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Theme.of(context).primaryColor,
                      Colors.deepPurple
                    ]),
                  ),
                  child: const Center(
                      child: Icon(Icons.check, color: Colors.white, size: 56)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('تمت إضافة البطاقة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('تم حفظ بطاقتك بنجاح ويمكنك استخدامها الآن.',
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/payments'),
                child: const Text('العودة إلى البطاقات'))
          ],
        ),
      ),
    );
  }
}
