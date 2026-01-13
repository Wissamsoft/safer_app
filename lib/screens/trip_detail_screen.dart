import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../core/tracking.dart';

class TripDetailScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  const TripDetailScreen(
      {super.key, required this.title, required this.subtitle});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  bool _tracking = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final val = await Tracking.isTracking(widget.title);
    if (mounted) setState(() => _tracking = val);
  }

  Future<void> _toggle() async {
    setState(() => _tracking = !_tracking);
    await Tracking.setTracking(widget.title, _tracking);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_tracking ? 'تم تفعيل المتابعة' : 'تم إلغاء المتابعة'),
          duration: const Duration(seconds: 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: TextStyle(
                    fontSize: rs(context, 20), fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.subtitle,
                style: TextStyle(
                    fontSize: rs(context, 14), color: Colors.black54)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.directions_car),
                      label: const Text('تفاصيل الحجز')),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Tooltip(
                    message: _tracking ? 'إلغاء المتابعة' : 'متابعة',
                    child: _tracking
                        ? ElevatedButton.icon(
                            onPressed: _toggle,
                            icon: const Icon(Icons.location_on,
                                color: Colors.white),
                            label: const Text('متابع',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                          )
                        : OutlinedButton.icon(
                            onPressed: _toggle,
                            style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).primaryColor),
                            icon: Icon(Icons.location_on,
                                color: Theme.of(context).primaryColor),
                            label: Text('متابعة',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
