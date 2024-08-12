import 'package:fe_mal/pages/anime_page.dart';
import 'package:fe_mal/pages/home_page.dart';
import 'package:fe_mal/pages/login_page.dart';
import 'package:fe_mal/pages/profile_page.dart';
import 'package:fe_mal/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(ThemeData.light()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.currentTheme,
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/anime': (context) => AnimePage(),
        '/profile': (context) => ProfilePage()
      },
    );
  }
}
