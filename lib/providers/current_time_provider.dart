import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/models/time_entry_model.dart';

final currentTimeProvider = StateProvider<TimeEntry?>((ref) => null);

final currentDNFProvider = StateProvider<bool>((ref) => false);
