import 'package:flutter/material.dart';
import '../core/mock_data.dart';
import '../core/responsive.dart';
import '../core/favorites_safe.dart';
import '../core/tracking.dart';

import '../widgets/route_transitions.dart';
import '../screens/transport_detail_screen.dart';

class TransportCard extends StatefulWidget {
  final Transport transport;
  const TransportCard({super.key, required this.transport});

  @override
  State<TransportCard> createState() => _TransportCardState();
}

class _TransportCardState extends State<TransportCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  bool _fav = false;
  bool _tracking = false;

  @override
  void initState() {
    super.initState();
    _loadFav();
    _loadTracking();
  }

  Future<void> _loadTracking() async {
    final val = await Tracking.isTracking(widget.transport.name);
    if (mounted) setState(() => _tracking = val);
  }

  Future<void> _toggleTracking() async {
    setState(() => _tracking = !_tracking);
    await Tracking.setTracking(widget.transport.name, _tracking);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_tracking ? 'تم تفعيل المتابعة' : 'تم إلغاء المتابعة'),
        duration: const Duration(seconds: 1),
      ));
    }
  }

  void _onTapDown(_) => setState(() => _scale = 0.97);
  void _onTapUp(_) => setState(() => _scale = 1.0);

  Future<void> _loadFav() async {
    final val = await Favorites.get(widget.transport.name);
    if (mounted) setState(() => _fav = val);
  }

  Future<void> _toggleFav() async {
    setState(() => _fav = !_fav);
    await Favorites.set(widget.transport.name, _fav);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_fav ? 'أضيف إلى المفضلة' : 'أُزيل من المفضلة'),
        duration: const Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.transport;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _scale,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.42,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.of(context)
                  .push(createFadeRoute(TransportDetailScreen(transport: t)))
                  .then((_) => _loadTracking()),
              child: Semantics(
                button: true,
                label: '${t.name} - ${t.priceInfo} - اضغط لعرض التفاصيل',
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * 0.22,
                              child: Image.asset(
                                t.image,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, st) => Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                      child: Text(
                                          t.name
                                              .trim()
                                              .split(RegExp(r'\s+'))
                                              .map((s) =>
                                                  s.isNotEmpty ? s[0] : '')
                                              .take(2)
                                              .join()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: rs(context, 20)))),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 6,
                              top: 6,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  color: _tracking
                                      ? Theme.of(context).primaryColor
                                      : Colors.white.withAlpha(220),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Tooltip(
                                  message: _tracking ? 'متابع' : 'متابعة',
                                  child: Semantics(
                                    button: true,
                                    label: _tracking ? 'متابع' : 'متابعة',
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: _toggleTracking,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: rs(context, 14),
                                              color: _tracking
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                      .primaryColor,
                                            ),
                                            AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 180),
                                              transitionBuilder:
                                                  (child, anim) =>
                                                      FadeTransition(
                                                          opacity: anim,
                                                          child: child),
                                              child: _tracking
                                                  ? const Padding(
                                                      key: ValueKey('tracked'),
                                                      padding: EdgeInsets.only(
                                                          left: 4.0),
                                                      child: Text('متابع',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12)),
                                                    )
                                                  : const SizedBox(
                                                      key: ValueKey(
                                                          'not_tracked')),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Material(
                                color: Colors.white.withAlpha(220),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Tooltip(
                                  message: _fav ? 'مفضلة' : 'أضف للمفضلة',
                                  child: Semantics(
                                    button: true,
                                    label: _fav ? 'مفضلة' : 'أضف للمفضلة',
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: _toggleFav,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                            _fav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: rs(context, 18),
                                            color: _fav
                                                ? Colors.redAccent
                                                : Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: rs(context, 8)),
                      Text(t.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: rs(context, 14))),
                      SizedBox(height: rs(context, 4)),
                      Text(t.priceInfo,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: rs(context, 12))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
