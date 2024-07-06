import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'לשיר עם ליאורה',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Alef', // Make sure to add this font to your pubspec.yaml
      ),
      home: HomeScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('he', 'IL'),
      ],
      locale: const Locale('he', 'IL'),
    );
  }
}