import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speedclimbing/models/settings_model.dart';
import 'package:speedclimbing/providers/isar_provider.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  FutureOr<SettingsModel> build() {
    return getSettings();
  }

  Future<SettingsModel> getSettings() async {
    final isar = await ref.watch(isarInstanceProvider.future);
    SettingsModel? settings = await isar.settingsModels.where().findFirst();
    if (settings == null) {
      final newSettings = SettingsModel(
        id: 0,
        atMarksTime: 0,
        readyProcedure: true,
      );
      await isar.writeTxn(() async {
        await isar.settingsModels.put(newSettings);
      });
      return newSettings;
    }
    return settings;
  }

  Future<void> setAtMarksTime(int time) async {
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarInstanceProvider.future);
      await isar.writeTxn(() async {
        final settings = await getSettings();
        settings.atMarksTime = time;
        await isar.settingsModels.put(settings);
      });
      return getSettings();
    });
  }

  Future<void> setReadyProcedure(bool value) async {
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarInstanceProvider.future);
      await isar.writeTxn(() async {
        final settings = await getSettings();
        settings.readyProcedure = value;
        await isar.settingsModels.put(settings);
      });
      return getSettings();
    });
  }
}
