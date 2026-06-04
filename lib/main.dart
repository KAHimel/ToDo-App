import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODOs - A To Do List App',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF8B6F47),
        scaffoldBackgroundColor: const Color(0xFFF5F1EC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B6F47),
          foregroundColor: Color(0xFFF5F1EC),
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFD4A574),
          foregroundColor: Color(0xFF5C4033),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B6F47),
            foregroundColor: const Color(0xFFF5F1EC),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
