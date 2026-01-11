import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الدفع والبطاقات')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('بطاقاتك',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('VISA **** 1234'),
                subtitle: const Text('محمد الحسن'),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('إزالة'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/add_card'),
              child: const Text('إضافة بطاقة جديدة'),
            ),
          ],
        ),
      ),
    );
  }
}
