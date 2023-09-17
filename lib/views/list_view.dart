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

class HistoryListView extends ConsumerStatefulWidget {
  const HistoryListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HistoryListViewState();
}

class _HistoryListViewState extends ConsumerState<HistoryListView> {
  bool orderDateAscending = true;
  bool orderTimeAscending = false;

  @override
  Widget build(BuildContext context) {
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
                IntrinsicHeight(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            ref
                                .read(timeEntriesProvider.notifier)
                                .changeTimeEntryOrder(
                                    SortBy.date, orderDateAscending);
                            setState(() {
                              orderDateAscending = !orderDateAscending;
                            });
                          },
                          child: Row(
                            children: [
                              const Text('Date'),
                              const SizedBox(width: 5),
                              Icon(orderDateAscending
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward),
                            ],
                          )),
                      const SizedBox(width: 5),
                      const VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                          onPressed: () {
                            ref
                                .read(timeEntriesProvider.notifier)
                                .changeTimeEntryOrder(
                                    SortBy.time, orderTimeAscending);
                            setState(() {
                              orderTimeAscending = !orderTimeAscending;
                            });
                          },
                          child: Row(
                            children: [
                              const Text("Time"),
                              const SizedBox(width: 5),
                              Icon(orderTimeAscending
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward),
                            ],
                          ))
                    ],
                  ),
                ),
                SlidableAutoCloseBehavior(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final timeEntry = logs[index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Slidable(
                              groupTag: '0',
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    label: 'Edit',
                                    icon: Icons.edit,
                                    onPressed: (context) => {},
                                  ),
                                  SlidableAction(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    onPressed: (context) async {
                                      final bool? shouldDelete =
                                          await showConfirmDeleteDialog(
                                              context);
                                      if (shouldDelete != null &&
                                          shouldDelete) {
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Theme.of(context).cardColor,
                                  child: ExpansionTile(
                                    title: timeEntry.isDNF
                                        ? const Text('DNF')
                                        : Text(
                                            "${Duration(milliseconds: timeEntry.duration).inSeconds.toString().padLeft(2, '0')}.${timeEntry.duration.remainder(1000).toString().padLeft(3, '0')}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                    subtitle: Text(
                                      DateFormat('yyyy-MM-dd hh:mm')
                                          .format(timeEntry.date),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    expandedAlignment: Alignment.centerLeft,
                                    children: [
                                      const Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        indent: 15,
                                        endIndent: 15,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 8),
                                          child: Text(
                                            "Notes",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24, right: 24, bottom: 24),
                                        child: Text(timeEntry.notes),
                                      )
                                    ],
                                  ),
                                ),
                              )));
                    },
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
            loading: () => Column(
              children: [
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
