import 'package:isar/isar.dart';
part 'time_entry_model.g.dart';

@collection
class TimeEntry {
  Id id = Isar.autoIncrement;
  DateTime date;
  int duration; // in milliseconds
  bool isDNF;

  TimeEntry({required this.date, required this.duration, required this.isDNF});

  // TimeEntry? copyWith({DateTime? date, int? duration, bool? isDNF}) {
  //   return TimeEntry(
  //     date: date ?? this.date,
  //     duration: duration ?? this.duration,
  //     isDNF: isDNF ?? this.isDNF,
  //   );
  // }
}
