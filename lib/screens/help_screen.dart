import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مساعدة')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text('الأسئلة الشائعة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ExpansionTile(title: Text('كيف أحجز رحلة؟'), children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('اختر الرحلة ثم اضغط احجز واتبع التعليمات.'))
          ]),
          ExpansionTile(title: Text('كيف أدفع؟'), children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('أضف بطاقة في قائمة الدفع ثم اخترها عند الدفع.'))
          ]),
          ExpansionTile(title: Text('اتصل بالدعم'), children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'يمكنك ارسال رسالة عبر صفحة الدعم أو الاتصال بالرقم الموضح في التطبيق.'))
          ]),
        ],
      ),
    );
  }
}
