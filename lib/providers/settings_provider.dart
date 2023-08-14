import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speedclimbing/controllers/settings_controller.dart';
import 'package:speedclimbing/models/settings_model.dart';
import 'package:speedclimbing/providers/isar_provider.dart';

part 'settings_provider.g.dart';

@riverpod
Future<SettingsController> settingsController(SettingsControllerRef ref) async {
  final isar = await ref.watch(isarInstanceProvider.future);
  return SettingsController(isar);
}

@riverpod
Future<SettingsModel> settings(SettingsRef ref) async {
  final settingsController = await ref.watch(settingsControllerProvider.future);
  return settingsController.getSettings();
}
