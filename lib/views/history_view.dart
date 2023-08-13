import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/providers/time_entry_provider.dart';
import 'package:speedclimbing/widgets/placeholder_card.dart';

class HistoryView extends ConsumerWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeEntries = ref.watch(timeEntriesProvider);

    return SingleChildScrollView(
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
                      child: Container(
                        color: Theme.of(context).cardColor,
                        height: 50,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(timeEntry.date.toString()),
                                timeEntry.isDNF
                                    ? const Text('DNF')
                                    : Text(Duration(
                                            milliseconds: timeEntry.duration)
                                        .toString()),
                              ],
                            )),
                      ),
                    ),
                  );
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
                    height: 50,
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
    );
  }
}
