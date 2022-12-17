import 'package:alquran/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Quran Al-Karim',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF064663),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF064663),
          elevation: 0.0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
