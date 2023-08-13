import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speedclimbing/models/time_entry_model.dart';

part 'isar_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isarInstance(FutureProviderRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([TimeEntrySchema], directory: dir.path);
}
