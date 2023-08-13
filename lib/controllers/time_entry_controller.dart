import 'package:isar/isar.dart';
import 'package:speedclimbing/models/time_entry_model.dart';

class TimeEntryController {
  final Isar isar;

  TimeEntryController(this.isar);

  Future<void> addTimeEntry(TimeEntry newTimeEntry) async {
    await isar.writeTxn(() async {
      await isar.timeEntrys.put(newTimeEntry);
    });
  }

  Future<List<TimeEntry>> getTimeEntries() async {
    return isar.timeEntrys.where().findAll();
  }

  Future<void> deleteTimeEntry(int id) async {
    await isar.writeTxn(() async {
      await isar.timeEntrys.delete(id);
    });
  }

  Future<void> updateDNF(TimeEntry timeEntry, bool isDNF) async {
    print(timeEntry.id);

    await isar.writeTxn(() async {
      timeEntry.isDNF = isDNF;
      await isar.timeEntrys.put(timeEntry);
    });
  }
}
