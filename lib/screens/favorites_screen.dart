import 'package:flutter/material.dart';
import '../core/mock_data.dart';
import '../core/favorites.dart';
import '../core/responsive.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Transport> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ids = transports.map((t) => t.name).toList();
    final favIds = await Favorites.getAll(ids);
    setState(() {
      _items = transports.where((t) => favIds.contains(t.name)).toList();
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
                        trailing: IconButton(
                            onPressed: () => _remove(t),
                            icon: const Icon(Icons.delete)),
                      ),
                    );
                  },
                ),
    );
  }
}
