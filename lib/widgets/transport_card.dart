import 'package:flutter/material.dart';
import '../core/mock_data.dart';

class TransportCard extends StatefulWidget {
  final Transport transport;
  const TransportCard({super.key, required this.transport});

  @override
  State<TransportCard> createState() => _TransportCardState();
}

class _TransportCardState extends State<TransportCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(_) {
    setState(() => _scale = 0.97);
  }

  void _onTapUp(_) {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.transport;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: () {},
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _scale,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.42,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width *
                          0.22, // responsive
                      color: Theme.of(context)
                          .primaryColor
                          .withAlpha((0.12 * 255).round()),
                      child: Center(
                          child: Icon(Icons.directions_bus,
                              color: Theme.of(context).primaryColor, size: 40)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(t.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(t.priceInfo,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
