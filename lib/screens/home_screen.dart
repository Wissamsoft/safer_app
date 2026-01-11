import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import '../core/mock_data.dart';
import '../widgets/transport_card.dart';
import '../core/responsive.dart';

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
      appBar: AppBar(title: Text(_titles[_selected])),
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
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
                    children: trips
                        .map((t) => Card(
                              child: ListTile(
                                leading: Container(
                                    width: 56,
                                    height: 56,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.directions_car)),
                                title: Text(t.title),
                                subtitle: Text(t.subtitle),
                                trailing: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('احجز')),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/payments'),
                    icon: const Icon(Icons.payment),
                    label: const Text('الدفع')),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.history),
                    label: const Text('سجلات')),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.help_outline),
                    label: const Text('مساعدة')),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
