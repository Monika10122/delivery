import 'package:delivery_shop/screens/home_page.dart';
import 'package:delivery_shop/screens/login_register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/app_theme.dart';
import 'logic/current_widget.dart';
import 'screens/shopping_basket_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'YOUR API KEY',
          appId: 'YOUR APP ID',
          messagingSenderId: 'YOUR messagingSenderId',
          projectId: 'YOUR PROJECT ID'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CurrentWidgetNotifier(),
        ),
        ChangeNotifierProvider(create: (_) => BasketProvider()),
      ],
      child:
          Consumer<AppThemeProvider>(builder: (context, appThemeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Delivery',
          theme: appThemeProvider.lightTheme,
          home: const HomePage(),
          routes: {
            '/login_page': (BuildContext context) => const LoginPage(),
            '/home_page': (BuildContext context) => const HomePage(),
          },
        );
      }),
    );
  }
}
