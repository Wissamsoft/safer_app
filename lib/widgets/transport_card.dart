import 'package:flutter/material.dart';
import '../core/mock_data.dart';
import '../core/responsive.dart';
import '../core/favorites.dart';
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

  @override
  void initState() {
    super.initState();
    _loadFav();
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
                  .push(createFadeRoute(TransportDetailScreen(transport: t))),
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
                                color: Theme.of(context)
                                    .primaryColor
                                    .withAlpha((0.12 * 255).round()),
                                child: Center(
                                    child: Icon(Icons.directions_bus,
                                        color: Theme.of(context).primaryColor,
                                        size: rs(context, 36))),
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
                            color: Colors.black54, fontSize: rs(context, 12))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
