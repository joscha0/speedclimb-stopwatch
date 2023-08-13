import 'package:isar/isar.dart';
import 'package:speedclimbing/models/time_entry_model.dart';

class TimeEntryController {
  final Isar isar;

  TimeEntryController(this.isar);

  Future<void> addTimeEntry(DateTime date, int duration, bool didFinish) async {
    final newTimeEntry = TimeEntry()
      ..date = date
      ..duration = duration
      ..didFinish = didFinish;

    await isar.writeTxn(() async {
      await isar.timeEntrys.put(newTimeEntry);
    });
  }

  Future<List<TimeEntry>> getTimeEntries() async {
    return isar.timeEntrys.where().findAll();
  }
}
