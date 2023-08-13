import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/views/time_view.dart';

class TimerView extends ConsumerWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: Hero(
      tag: 'timeButton',
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const TimeView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),

          padding: EdgeInsets.all(60),
          backgroundColor: Colors.red, // <-- Button color
          foregroundColor: Colors.white, // <-- Splash color
        ),
        child: const Text(
          'START',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
