import 'dart:async';

import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_entries_provider.g.dart';

@riverpod
class TimeEntries extends _$TimeEntries {
  Future<List<TimeEntry>> getLogs() async {
    return [];
  }

  @override
  FutureOr<List<TimeEntry>> build() {
    return getLogs();
  }
}
