import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:speedclimbing/providers/current_time_provider.dart';
import 'package:speedclimbing/providers/settings_provider.dart';
import 'package:speedclimbing/providers/time_entry_provider.dart';
import 'package:speedclimbing/views/home_view.dart';
import 'package:speedclimbing/widgets/flight_animation.dart';

class TimeView extends ConsumerStatefulWidget {
  const TimeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimeViewState();
}

class _TimeViewState extends ConsumerState<TimeView> {
  final stopwatch = Stopwatch();
  late Timer _timer;
  String text = '';
  static AudioPlayer player = new AudioPlayer();

  void startTimer() {
    stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    ref.read(settingsProvider.future).then((value) {
      if (value.atMarksTime > 0) {
        setState(() {
          text = 'At your marks';
        });
      }
      if (value.readyProcedure) {
        _timer = Timer(Duration(milliseconds: value.atMarksTime), () {
          setState(() {
            text = 'Ready';
          });
          _timer = Timer(const Duration(seconds: 1), () {
            player.play(AssetSource("880.wav"));
            setState(() {
              text = '1';
            });
            _timer = Timer(const Duration(seconds: 1), () {
              player.play(AssetSource("880.wav"));
              setState(() {
                text = '2';
              });
              _timer = Timer(const Duration(seconds: 1), () {
                player.play(AssetSource("1760.wav"));
                startTimer();
              });
            });
          });
        });
      } else {
        player.play(AssetSource("1760.wav"));
        startTimer();
      }
    });
  }

  @override
  void dispose() {
    stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  void goHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  void saveTime() async {
    TimeEntry newEntry = TimeEntry(
        date: DateTime.now(),
        duration: stopwatch.elapsed.inMilliseconds,
        isDNF: false);
    ref.read(timeEntriesProvider.notifier).addTimeEntry(newEntry);
    ref.read(currentTimeProvider.notifier).state = newEntry;
    goHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'timeLabel',
              flightShuttleBuilder: flightShuttleBuilder,
              child: Text(
                  stopwatch.isRunning
                      ? '${stopwatch.elapsed.inSeconds.toString().padLeft(2, '0')}.${stopwatch.elapsed.inMilliseconds.remainder(1000).toString().padLeft(3, '0')}'
                      : text,
                  style: const TextStyle(fontSize: 52, fontFeatures: [
                    FontFeature.tabularFigures(),
                  ])),
            ),
            const Row(),
            const SizedBox(
              height: 100,
            ),
            Hero(
              tag: 'timeButton',
              child: ElevatedButton(
                onPressed: stopwatch.isRunning ? saveTime : goHome,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(70),
                  backgroundColor: stopwatch.isRunning
                      ? Colors.red
                      : Colors.grey[800], // <-- Button color
                  foregroundColor: Colors.white, // <-- Splash color
                ),
                child: Text(
                  stopwatch.isRunning ? 'STOP' : 'CANCEL',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }
}
