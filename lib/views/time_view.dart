import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/views/home_view.dart';

class TimeView extends ConsumerWidget {
  const TimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Time'),
            Row(),
            Hero(
              tag: 'timeButton',
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const HomeView(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(60),
                  backgroundColor: Colors.red, // <-- Button color
                  foregroundColor: Colors.white, // <-- Splash color
                ),
                child: const Text(
                  'STOP',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }
}
