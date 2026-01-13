import 'package:flutter/material.dart';
import '../core/mock_data.dart';
import '../core/responsive.dart';
import '../core/tracking.dart';

class TransportDetailScreen extends StatefulWidget {
  final Transport transport;
  const TransportDetailScreen({super.key, required this.transport});

  @override
  State<TransportDetailScreen> createState() => _TransportDetailScreenState();
}

class _TransportDetailScreenState extends State<TransportDetailScreen> {
  bool _tracking = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final val = await Tracking.isTracking(widget.transport.name);
    if (mounted) setState(() => _tracking = val);
  }

  Future<void> _toggle() async {
    setState(() => _tracking = !_tracking);
    await Tracking.setTracking(widget.transport.name, _tracking);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_tracking ? 'تم تفعيل المتابعة' : 'تم إلغاء المتابعة'),
          duration: const Duration(seconds: 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final transport = widget.transport;

    return Scaffold(
      appBar: AppBar(title: Text(transport.name)),
      body: SingleChildScrollView(
        child: Padding(
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
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.payment),
                        label: const Text('احجز الآن')),
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
      ),
    );
  }
}
