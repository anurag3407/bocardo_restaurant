import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bocardo_restaurant/firebase_options.dart';
import 'package:bocardo_restaurant/screens/auth_test_bench_page.dart';
import 'package:bocardo_restaurant/screens/login_page.dart';
import 'package:bocardo_restaurant/screens/restaurant_home_page.dart';
import 'package:bocardo_restaurant/screens/signup_page.dart';
import 'package:bocardo_restaurant/services/supabase_auth_service.dart';
import 'package:bocardo_restaurant/themes/brand.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Firebase if configured
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('[Firebase] Warning during initialization: $e');
  }

  // 2. Initialize Supabase with PKCE Auth flow
  try {
    await SupabaseAuthService.instance.initialize();
  } catch (e) {
    debugPrint('[Supabase] Warning during initialization: $e');
  }

  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bocardo Restaurant',
      debugShowCheckedModeBanner: false,
      theme: brandTheme(),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignupPage(),
        '/home': (_) => const RestaurantHomePage(),
        '/auth-test-bench': (_) => const AuthTestBenchPage(),
      },
    );
  }
}
