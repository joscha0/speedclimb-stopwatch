import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/views/home_view.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    elevation: 0,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  primarySwatch: Colors.red,
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeView(),
      theme: darkTheme,
    );
  }
}
