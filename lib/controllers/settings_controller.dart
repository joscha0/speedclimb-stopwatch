import 'package:isar/isar.dart';
import 'package:speedclimbing/models/settings_model.dart';

class SettingsController {
  final Isar isar;

  SettingsController(this.isar);

  Future<void> setAtMarksTime(SettingsModel settings, int time) async {
    await isar.writeTxn(() async {
      settings.atMarksTime = time;
      await isar.settingsModels.put(settings);
    });
  }

  Future<SettingsModel> getSettings() async {
    return await isar.settingsModels.where().findFirst() ?? SettingsModel();
  }
}
