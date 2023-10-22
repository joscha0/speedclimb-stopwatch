import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:speedclimbing/providers/time_entry_provider.dart';
import 'package:speedclimbing/widgets/placeholder_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryGraphView extends ConsumerWidget {
  const HistoryGraphView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeEntries = ref.watch(timeEntriesProvider);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: timeEntries.when(
            data: (logs) => logs.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: SfCartesianChart(
                            primaryXAxis: DateTimeAxis(),
                            trackballBehavior: TrackballBehavior(
                              enable: true,
                              markerSettings: const TrackballMarkerSettings(
                                color: Colors.red,
                                markerVisibility:
                                    TrackballVisibilityMode.visible,
                                height: 10,
                                width: 10,
                                borderWidth: 1,
                                borderColor: Colors.white,
                              ),
                              hideDelay: 4000,
                              activationMode: ActivationMode.singleTap,
                              tooltipSettings: const InteractiveTooltip(
                                format: 'point.x : point.y',
                              ),
                              shouldAlwaysShow: false,
                            ),
                            zoomPanBehavior: ZoomPanBehavior(
                              zoomMode: ZoomMode.x,
                              enablePinching: true,
                              enablePanning: true,
                              enableDoubleTapZooming: true,
                              enableMouseWheelZooming: true,
                              enableSelectionZooming: true,
                            ),
                            series: <LineSeries<TimeEntry, DateTime>>[
                              LineSeries<TimeEntry, DateTime>(
                                width: 4,
                                color: Colors.red,
                                dataSource: logs,
                                sortingOrder: SortingOrder.descending,
                                sortFieldValueMapper: (datum, index) =>
                                    datum.date,
                                xValueMapper: (TimeEntry log, _) => log.date,
                                yValueMapper: (TimeEntry log, _) =>
                                    log.duration / 1000,
                              )
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            "PB: ${Duration(milliseconds: logs.map((e) => e.duration).toList().reduce(min)).inSeconds.toString().padLeft(2, '0')}.${logs.map((e) => e.duration).toList().reduce(min).remainder(1000).toString().padLeft(3, '0')}",
                            style: const TextStyle(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  )
                : const Center(
                    child: Text("No data"),
                  ),
            loading: () => const Column(
              children: [
                PlaceholderCard(
                  width: double.infinity,
                  height: 300,
                  borderRadius: 20,
                ),
              ],
            ),
            error: (error, stack) =>
                Text('Error fetching logs: ${error.toString()}'),
          ),
        ),
      ),
    );
  }
}
