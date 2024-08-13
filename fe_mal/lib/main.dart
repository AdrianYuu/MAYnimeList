import "package:fe_mal/pages/login_page.dart";
import "package:fe_mal/theme/theme_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(ThemeData.dark()),
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
      home: LoginPage(),
    );
  }
}
