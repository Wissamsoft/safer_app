import 'package:flutter/material.dart';
import '../core/mock_data.dart';
import '../core/favorites_safe.dart';
import '../core/tracking.dart';
import '../core/responsive.dart';
import '../widgets/route_transitions.dart';
import 'transport_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Transport> _items = [];
  bool _loading = true;
  Set<String> _tracked = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ids = transports.map((t) => t.name).toList();
    final favIds = await Favorites.getAll(ids);
    final tracked = await Tracking.getAll(ids);
    setState(() {
      _items = transports.where((t) => favIds.contains(t.name)).toList();
      _tracked = tracked.toSet();
      _loading = false;
    });
  }

  Future<void> _remove(Transport t) async {
    await Favorites.remove(t.name);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المفضلات')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? Center(child: Text('لا توجد عناصر في المفضلات'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _items.length,
                  itemBuilder: (context, i) {
                    final t = _items[i];
                    return Card(
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .push(createFadeRoute(
                                TransportDetailScreen(transport: t)))
                            .then((_) => _load()),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: rs(context, 56),
                            height: rs(context, 56),
                            child: Image.asset(t.image, fit: BoxFit.cover),
                          ),
                        ),
                        title: Text(t.name,
                            style: TextStyle(fontSize: rs(context, 16))),
                        subtitle: Text(t.priceInfo),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_tracked.contains(t.name))
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 8.0),
                                child: Chip(
                                  label: const Text('متابع',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                            IconButton(
                                onPressed: () => _remove(t),
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
