import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:speedclimbing/providers/time_entry_provider.dart';
import 'package:speedclimbing/widgets/add_time_dialog.dart';
import 'package:speedclimbing/widgets/confirm_delete_dialog.dart';
import 'package:speedclimbing/widgets/placeholder_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryListView extends ConsumerWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeEntries = ref.watch(timeEntriesProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (context) {
                return const AddTimeDialog();
              });
        },
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
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) async {
                                    final bool? shouldDelete =
                                        await showConfirmDeleteDialog(context);
                                    if (shouldDelete != null && shouldDelete) {
                                      ref
                                          .read(timeEntriesProvider.notifier)
                                          .deleteTimeEntry(timeEntry.id);
                                    }
                                  },
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
                const SizedBox(
                  height: 100,
                )
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
