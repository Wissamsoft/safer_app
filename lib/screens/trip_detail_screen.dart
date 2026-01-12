import 'package:flutter/material.dart';
import '../core/responsive.dart';

class TripDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  const TripDetailScreen(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: rs(context, 20), fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(subtitle,
                style: TextStyle(
                    fontSize: rs(context, 14), color: Colors.black54)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.directions_car),
                label: const Text('تفاصيل الحجز'))
          ],
        ),
      ),
    );
  }
}
