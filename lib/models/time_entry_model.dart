import 'package:isar/isar.dart';
part 'time_entry_model.g.dart';

@collection
class TimeEntry {
  Id id = Isar.autoIncrement;
  DateTime? date;
  int? duration; // in milliseconds
  bool? didFinish;
}
