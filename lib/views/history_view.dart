import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:speedclimbing/providers/time_entry_provider.dart';
import 'package:speedclimbing/widgets/placeholder_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryView extends ConsumerWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeEntries = ref.watch(timeEntriesProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 1,
        hoverElevation: 2,
        highlightElevation: 2,
        label: const Text('Add time'),
        icon: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: timeEntries.when(
            data: (logs) => Column(
              children: [
                SizedBox(
                  height: 300,
                  child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(),
                      trackballBehavior: TrackballBehavior(
                        enable: true,
                        markerSettings: const TrackballMarkerSettings(
                          color: Colors.red,
                          markerVisibility: TrackballVisibilityMode.visible,
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
                          xValueMapper: (TimeEntry log, _) => log.date,
                          yValueMapper: (TimeEntry log, _) =>
                              log.duration / 1000,
                        )
                      ]),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final timeEntry = logs[index];
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Container(
                              color: Theme.of(context).cardColor,
                              height: 70,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat('yyyy-MM-dd hh:mm')
                                            .format(timeEntry.date),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      timeEntry.isDNF
                                          ? const Text('DNF')
                                          : Text(
                                              "${Duration(milliseconds: timeEntry.duration).inSeconds.toString().padLeft(2, '0')}.${timeEntry.duration.remainder(1000).toString().padLeft(3, '0')}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                    ],
                                  )),
                            ),
                          ),
                        ));
                  },
                ),
              ],
            ),
            loading: () => Column(
              children: [
                const PlaceholderCard(
                  width: double.infinity,
                  height: 300,
                  borderRadius: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const PlaceholderCard(
                      width: double.infinity,
                      height: 70,
                      borderRadius: 20,
                    );
                  },
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
