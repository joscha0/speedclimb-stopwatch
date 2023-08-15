import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@collection
class SettingsModel {
  Id id = 0;
  int atMarksTime = 0;
  bool readyProcedure = true;

  SettingsModel({
    required this.id,
    required this.atMarksTime,
    required this.readyProcedure,
  });

  SettingsModel? copyWith({
    Id? id,
    int? atMarksTime,
    bool? readyProcedure,
  }) {
    return SettingsModel(
      id: id ?? this.id,
      atMarksTime: atMarksTime ?? this.atMarksTime,
      readyProcedure: readyProcedure ?? this.readyProcedure,
    );
  }
}
