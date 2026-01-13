import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import '../core/mock_data.dart';
import '../widgets/transport_card.dart';
import '../core/responsive.dart';
import '../screens/trip_detail_screen.dart';
import '../widgets/route_transitions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selected = 2; // default to center home

  final List<Widget> _pages = [
    const Center(child: Text('العروض')),
    const Center(child: Text('الرحلات')),
    const HomeContent(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  final List<String> _titles = [
    'العروض',
    'الرحلات',
    'الرئيسية',
    'الخريطة',
    'الملف'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selected]), actions: [
        IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/favorites'),
            icon: const Icon(Icons.favorite)),
        if (kDebugMode)
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'all') Navigator.of(context).pushNamed('/all_screens');
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'all', child: Text('عرض كل الشاشات'))
            ],
          ),
      ]),
      body: _pages[_selected],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selected,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _selected = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'عروض'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'رحلات'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'الخريطة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف'),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 120),
        () => setState(() => _visible = true));
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
                child: Text(title,
                    style: TextStyle(
                        fontSize: rs(context, 16),
                        fontWeight: FontWeight.bold))),
            const Icon(Icons.chevron_left, size: 20, color: Colors.black26),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ابحث عن مكان أو خدمة',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                    splashRadius: 22,
                  ),
                ),
              ],
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _visible ? 1.0 : 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle('شركات النقل'),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.52,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: transports.length,
                    itemBuilder: (context, i) {
                      final t = transports[i];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: TransportCard(transport: t),
                      );
                    },
                  ),
                ),
                _sectionTitle('الرحلات المقترحة'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: trips.asMap().entries.map((entry) {
                      final i = entry.key;
                      final t = entry.value;
                      final img =
                          t.image ?? transports[i % transports.length].image;
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          onTap: () => Navigator.of(context).push(
                              createFadeRoute(TripDetailScreen(
                                  title: t.title, subtitle: t.subtitle))),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: rs(context, 56),
                              height: rs(context, 56),
                              child: Image.asset(
                                img,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, st) => Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withAlpha(40),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      t.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: rs(context, 12)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Text(t.title,
                              style: TextStyle(
                                  fontSize: rs(context, 16),
                                  fontWeight: FontWeight.w600)),
                          subtitle: Text(t.subtitle,
                              style: TextStyle(
                                  fontSize: rs(context, 12),
                                  color: Colors.black54)),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize:
                                  Size(rs(context, 64), rs(context, 36)),
                            ),
                            child: const Text('احجز الآن',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Tooltip(
                    message: 'الدفع',
                    child: Semantics(
                      button: true,
                      label: 'الدفع',
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/payments'),
                        icon: const Icon(Icons.payment, color: Colors.white),
                        label: const Text('الدفع',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Tooltip(
                    message: 'سجلات',
                    child: Semantics(
                      button: true,
                      label: 'سجلات',
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.history, color: Colors.white),
                        label: const Text('سجلات',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(
                                const SnackBar(content: Text('فتح السجلات'))),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Tooltip(
                    message: 'مساعدة',
                    child: Semantics(
                      button: true,
                      label: 'مساعدة',
                      child: ElevatedButton.icon(
                        icon:
                            const Icon(Icons.help_outline, color: Colors.white),
                        label: const Text('مساعدة',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(
                                const SnackBar(content: Text('فتح المساعدة'))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
