import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:speedclimbing/providers/current_time_provider.dart';
import 'package:speedclimbing/providers/time_entry_provider.dart';
import 'package:speedclimbing/views/time_view.dart';
import 'package:speedclimbing/widgets/add_note_dialog.dart';
import 'package:speedclimbing/widgets/confirm_delete_dialog.dart';
import 'package:speedclimbing/widgets/flight_animation.dart';

class TimerView extends ConsumerStatefulWidget {
  const TimerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimerViewState();
}

class _TimerViewState extends ConsumerState<TimerView> {
  void updateDNF(TimeEntry currentTime, bool newIsDNF) async {
    ref.read(timeEntriesProvider.notifier).updateDNF(currentTime, newIsDNF);
    ref.read(currentDNFProvider.notifier).update((state) => newIsDNF);
  }

  @override
  Widget build(BuildContext context) {
    TimeEntry? currentTime = ref.watch(currentTimeProvider);
    bool currentDNF = ref.watch(currentDNFProvider);
    return Center(
        child: currentTime != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'timeLabel',
                    flightShuttleBuilder: flightShuttleBuilder,
                    child: currentDNF
                        ? const Text(
                            'DNF',
                            style: TextStyle(fontSize: 52),
                          )
                        : Text(
                            '${Duration(milliseconds: currentTime.duration).inSeconds.toString().padLeft(2, '0')}.${(currentTime.duration).remainder(1000).toString().padLeft(3, '0')}',
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
                  currentDNF
                      ? IconButton(
                          onPressed: () {
                            updateDNF(currentTime, false);
                          },
                          icon: const Icon(Icons.undo))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final bool? shouldDelete =
                                      await showConfirmDeleteDialog(context);
                                  if (shouldDelete != null && shouldDelete) {
                                    ref
                                        .read(timeEntriesProvider.notifier)
                                        .deleteTimeEntry(
                                          currentTime.id,
                                        );
                                    ref
                                        .read(currentTimeProvider.notifier)
                                        .update((state) => null);
                                  }
                                },
                                icon: const Icon(Icons.close)),
                            IconButton(
                                onPressed: () {
                                  updateDNF(currentTime, true);
                                },
                                icon: const Icon(Icons.block)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AddNoteDialog(
                                          currentTime: currentTime));
                                },
                                icon: const Icon(Icons.edit))
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
