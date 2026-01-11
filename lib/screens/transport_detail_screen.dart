import 'package:flutter/material.dart';
import '../core/mock_data.dart';
import '../core/responsive.dart';

class TransportDetailScreen extends StatelessWidget {
  final Transport transport;
  const TransportDetailScreen({super.key, required this.transport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(transport.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                transport.image,
                width: double.infinity,
                height: rs(context, 200),
                fit: BoxFit.cover,
                errorBuilder: (ctx, e, st) => Container(
                  width: double.infinity,
                  height: rs(context, 200),
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.directions_bus)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(transport.name,
                style: TextStyle(
                    fontSize: rs(context, 20), fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(transport.priceInfo,
                style: TextStyle(
                    fontSize: rs(context, 14), color: Colors.black54)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.payment),
                label: const Text('احجز الآن'))
          ],
        ),
      ),
    );
  }
}
