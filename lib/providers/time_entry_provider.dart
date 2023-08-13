import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speedclimbing/controllers/time_entry_controller.dart';
import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:speedclimbing/providers/isar_provider.dart';

part 'time_entry_provider.g.dart';

@riverpod
Future<TimeEntryController> timeEntryController(
    TimeEntryControllerRef ref) async {
  final isar = await ref.watch(isarInstanceProvider.future);
  return TimeEntryController(isar);
}

@riverpod
Future<List<TimeEntry>> timeEntries(TimeEntriesRef ref) async {
  final timeEntryController =
      await ref.watch(timeEntryControllerProvider.future);
  return timeEntryController.getTimeEntries();
}
