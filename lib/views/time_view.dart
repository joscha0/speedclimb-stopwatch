import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:speedclimbing/views/home_view.dart';

class TimeView extends StatefulWidget {
  const TimeView({super.key});

  @override
  State<TimeView> createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  final stopwatch = Stopwatch();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                '${stopwatch.elapsed.inSeconds.toString().padLeft(2, '0')}.${stopwatch.elapsed.inMilliseconds.remainder(1000).toString().padLeft(3, '0')}',
                style: const TextStyle(fontSize: 52, fontFeatures: [
                  FontFeature.tabularFigures(),
                ])),
            const Row(),
            const SizedBox(
              height: 100,
            ),
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
