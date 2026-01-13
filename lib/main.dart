import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';
import 'screens/payments_screen.dart';
import 'screens/add_card_screen.dart';
import 'screens/payment_success_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_edit_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/all_screens.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Warm up SharedPreferences to reduce chance of platform channel errors
  try {
    await SharedPreferences.getInstance();
  } catch (e) {
    debugPrint('SharedPreferences warmup failed: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safer App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const SplashScreen(),
      routes: {
        '/onboarding': (_) => const OnboardingScreen(),
        '/home': (_) => const HomeScreen(),
        '/payments': (_) => const PaymentsScreen(),
        '/add_card': (_) => const AddCardScreen(),
        '/payment_success': (_) => const PaymentSuccessScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/map': (_) => const MapScreen(),
        '/profile_edit': (_) => const ProfileEditScreen(),
        '/settings': (_) => const SettingsScreen(),
        '/help': (_) => const HelpScreen(),
        '/favorites': (_) => const FavoritesScreen(),
        '/all_screens': (_) => const AllScreens(),
      },
    );
  }
}
