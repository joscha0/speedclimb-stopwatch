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
  checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.resolveWith(((states) =>
          states.any((element) => element == MaterialState.selected)
              ? Colors.red
              : Colors.transparent))),
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
      theme: darkTheme,
    );
  }
}
