import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:speedclimbing/providers/isar_provider.dart';

part 'time_entry_provider.g.dart';

enum SortBy { date, time }

@riverpod
class TimeEntries extends _$TimeEntries {
  @override
  FutureOr<List<TimeEntry>> build() {
    return getTimeEntries();
  }

  Future<List<TimeEntry>> getTimeEntries() async {
    final isar = await ref.watch(isarInstanceProvider.future);
    return isar.timeEntrys.where().sortByDateDesc().findAll();
  }

  Future<void> addTimeEntry(TimeEntry timeEntry) async {
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarInstanceProvider.future);
      await isar.writeTxn(() async {
        await isar.timeEntrys.put(timeEntry);
      });
      return await getTimeEntries();
    });
  }

  Future<void> changeTimeEntryOrder(SortBy order, bool isAscending) async {
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarInstanceProvider.future);
      switch (order) {
        case SortBy.date:
          if (isAscending) {
            return isar.timeEntrys.where().sortByDate().findAll();
          }
          return isar.timeEntrys.where().sortByDateDesc().findAll();
        case SortBy.time:
          if (isAscending) {
            return isar.timeEntrys.where().sortByDuration().findAll();
          }
          return isar.timeEntrys.where().sortByDurationDesc().findAll();
      }
    });
  }

  Future<void> deleteTimeEntry(int timeEntryId) async {
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarInstanceProvider.future);
      await isar.writeTxn(() async {
        await isar.timeEntrys.delete(timeEntryId);
      });
      return getTimeEntries();
    });
  }

  Future<void> updateDNF(TimeEntry timeEntry, bool isDNF) async {
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarInstanceProvider.future);
      await isar.writeTxn(() async {
        timeEntry.isDNF = isDNF;
        await isar.timeEntrys.put(timeEntry);
      });
      return await getTimeEntries();
    });
  }

  Future<void> updateNote(TimeEntry timeEntry, String newNote) async {
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarInstanceProvider.future);
      await isar.writeTxn(() async {
        timeEntry.notes = newNote;
        await isar.timeEntrys.put(timeEntry);
      });
      return await getTimeEntries();
    });
  }
}
