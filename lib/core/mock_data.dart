class Transport {
  final String name;
  final String priceInfo;
  final String image; // placeholder path
  Transport(this.name, this.priceInfo, this.image);
}

final transports = <Transport>[
  Transport('شركة السريع', 'من 5 SAR', 'assets/images/transport1.png'),
  Transport('VIP النقل', 'من 12 SAR', 'assets/images/transport2.png'),
  Transport('الأفضل', 'من 8 SAR', 'assets/images/transport3.png'),
  Transport(
      'شركة نجمة الصافي للنقل البري', 'من 10 SAR', 'assets/images/2.webp'),
  Transport('شركة الافضل للنقل البري', 'من 9 SAR', 'assets/images/4.jpeg'),
  Transport('شركة البركة للنقل البري', 'من 7 SAR', 'assets/images/1.jfif'),
  Transport('شركة المتصدر للنقل البري', 'من 11 SAR', 'assets/images/3.jpg'),
];

class Trip {
  final String title;
  final String subtitle;
  Trip(this.title, this.subtitle);
}

final trips =
    List.generate(5, (i) => Trip('رحلة ${i + 1}', 'من 0 إلى 20 دقيقة'));
