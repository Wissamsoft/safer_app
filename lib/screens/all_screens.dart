import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'transport_detail_screen.dart';
import 'trip_detail_screen.dart';
import '../core/mock_data.dart';

class AllScreens extends StatelessWidget {
  const AllScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleTransport = transports.first;
    return Scaffold(
      appBar: AppBar(title: const Text('جميع الشاشات')),
      body: ListView(
        children: [
          // Account header
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('الحساب',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('عرض الملف الشخصي',
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/profile'),
                    icon: const Icon(Icons.arrow_forward_ios, size: 18)),
              ],
            ),
          ),

          const Divider(height: 1),

          // Pages section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('الصفحات',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('الرئيسية'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('الدفع'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/payments'),
          ),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text('إضافة بطاقة'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/add_card'),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle_outline),
            title: const Text('تم الدفع'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/payment_success'),
          ),

          const Divider(height: 1),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('الملف والاعدادات',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('الملف الشخصي'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('تعديل الملف'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/profile_edit'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('الإعدادات'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),

          const Divider(height: 1),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('اكتشف',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
          ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: const Text('الخريطة'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/map'),
          ),
          ListTile(
            leading: const Icon(Icons.flight),
            title: const Text('الرحلات'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('المفضلات'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/favorites'),
          ),

          const Divider(height: 1),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('نماذج',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('تفاصيل الرحلة (نموذج)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const TripDetailScreen(
                        title: 'رحلة تجريبية', subtitle: 'نموذج'))),
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping),
            title: const Text('تفاصيل الناقل (نموذج)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        TransportDetailScreen(transport: sampleTransport))),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
