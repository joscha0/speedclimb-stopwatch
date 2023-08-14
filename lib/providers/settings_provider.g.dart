// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsControllerHash() =>
    r'2be2104f12c07813b064b1b589ffb001f1590cb2';

/// See also [settingsController].
@ProviderFor(settingsController)
final settingsControllerProvider =
    AutoDisposeFutureProvider<SettingsController>.internal(
  settingsController,
  name: r'settingsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SettingsControllerRef
    = AutoDisposeFutureProviderRef<SettingsController>;
String _$settingsHash() => r'f99a1079a85f2220577e6e21366c56ce9d11ea60';

/// See also [settings].
@ProviderFor(settings)
final settingsProvider = AutoDisposeFutureProvider<SettingsModel>.internal(
  settings,
  name: r'settingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$settingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SettingsRef = AutoDisposeFutureProviderRef<SettingsModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
