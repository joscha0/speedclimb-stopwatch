// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_entry_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timeEntryControllerHash() =>
    r'bd2c475269c165b077f6ecfc1f22feadfa0e033f';

/// See also [timeEntryController].
@ProviderFor(timeEntryController)
final timeEntryControllerProvider =
    AutoDisposeFutureProvider<TimeEntryController>.internal(
  timeEntryController,
  name: r'timeEntryControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timeEntryControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TimeEntryControllerRef
    = AutoDisposeFutureProviderRef<TimeEntryController>;
String _$timeEntriesHash() => r'20d17d97c8b48e894afd605b673cc50dd30a0405';

/// See also [timeEntries].
@ProviderFor(timeEntries)
final timeEntriesProvider = AutoDisposeFutureProvider<List<TimeEntry>>.internal(
  timeEntries,
  name: r'timeEntriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$timeEntriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TimeEntriesRef = AutoDisposeFutureProviderRef<List<TimeEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
