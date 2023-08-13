import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/providers/current_time_provider.dart';
import 'package:speedclimbing/views/time_view.dart';
import 'package:speedclimbing/widgets/flight_animation.dart';

class TimerView extends ConsumerStatefulWidget {
  const TimerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimerViewState();
}

class _TimerViewState extends ConsumerState<TimerView> {
  bool isDNF = false;

  @override
  Widget build(BuildContext context) {
    Duration? currentTime = ref.watch(currentTimeProvider);
    return Center(
        child: currentTime != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'timeLabel',
                    flightShuttleBuilder: flightShuttleBuilder,
                    child: isDNF
                        ? const Text(
                            'DNF',
                            style: TextStyle(fontSize: 52),
                          )
                        : Text(
                            '${currentTime.inSeconds.toString().padLeft(2, '0')}.${currentTime.inMilliseconds.remainder(1000).toString().padLeft(3, '0')}',
                            style: const TextStyle(
                                fontSize: 52,
                                fontFeatures: [
                                  FontFeature.tabularFigures(),
                                ],
                                color: Colors.greenAccent)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isDNF
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isDNF = false;
                            });
                          },
                          icon: const Icon(Icons.undo))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.close)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isDNF = true;
                                  });
                                },
                                icon: const Icon(Icons.block))
                          ],
                        ),
                  const SizedBox(
                    height: 100,
                  ),
                  Hero(
                    tag: 'timeButton',
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const TimeView(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return child;
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(70),
                        backgroundColor: Colors.grey[800], // <-- Button color
                        foregroundColor: Colors.white, // <-- Splash color
                      ),
                      child: const Text(
                        'RESTART',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            : Hero(
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
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(70),
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
