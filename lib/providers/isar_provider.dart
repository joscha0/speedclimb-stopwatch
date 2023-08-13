import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speedclimbing/models/time_entry_model.dart';

final isarPod = FutureProvider((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([TimeEntrySchema], directory: dir.path);
});
