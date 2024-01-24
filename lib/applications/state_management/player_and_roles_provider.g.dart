// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_and_roles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$limitLockHash() => r'1e5a40d1dfc4a6966c2ef90e26785828d63f2330';

/// See also [LimitLock].
@ProviderFor(LimitLock)
final limitLockProvider = AutoDisposeNotifierProvider<LimitLock, bool>.internal(
  LimitLock.new,
  name: r'limitLockProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$limitLockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LimitLock = AutoDisposeNotifier<bool>;
String _$starRoleHash() => r'7f866f8b0b3ddbd7b7bc61eb4309d835638dbe61';

/// See also [StarRole].
@ProviderFor(StarRole)
final starRoleProvider = AutoDisposeNotifierProvider<StarRole, bool>.internal(
  StarRole.new,
  name: r'starRoleProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$starRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StarRole = AutoDisposeNotifier<bool>;
String _$playerNamesHash() => r'7f26b8248e059efffdeacbd0012fa106ea863573';

/// See also [PlayerNames].
@ProviderFor(PlayerNames)
final playerNamesProvider =
    AutoDisposeNotifierProvider<PlayerNames, List<String>>.internal(
  PlayerNames.new,
  name: r'playerNamesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playerNamesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PlayerNames = AutoDisposeNotifier<List<String>>;
String _$mafiasHash() => r'6aeb02150e5d9d1940f6562d6ea7d800dacdd841';

/// See also [Mafias].
@ProviderFor(Mafias)
final mafiasProvider = AutoDisposeNotifierProvider<Mafias, List<Role>>.internal(
  Mafias.new,
  name: r'mafiasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mafiasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Mafias = AutoDisposeNotifier<List<Role>>;
String _$citizensHash() => r'4c75ac849492f44a1cc283acadded2b787a80e31';

/// See also [Citizens].
@ProviderFor(Citizens)
final citizensProvider =
    AutoDisposeNotifierProvider<Citizens, List<Role>>.internal(
  Citizens.new,
  name: r'citizensProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$citizensHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Citizens = AutoDisposeNotifier<List<Role>>;
String _$independentsHash() => r'cc46c19adccc6f34efa502e2b0dd66d1ac17f225';

/// See also [Independents].
@ProviderFor(Independents)
final independentsProvider =
    AutoDisposeNotifierProvider<Independents, List<Role>>.internal(
  Independents.new,
  name: r'independentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$independentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Independents = AutoDisposeNotifier<List<Role>>;
String _$selectedMafiaHash() => r'57a60b785a521d94f42113d4b09eb298056e7b20';

/// See also [SelectedMafia].
@ProviderFor(SelectedMafia)
final selectedMafiaProvider =
    AutoDisposeNotifierProvider<SelectedMafia, int>.internal(
  SelectedMafia.new,
  name: r'selectedMafiaProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedMafiaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedMafia = AutoDisposeNotifier<int>;
String _$selectedCitizenHash() => r'ce29f2fcde84d930f245e3acb44da87c643b032a';

/// See also [SelectedCitizen].
@ProviderFor(SelectedCitizen)
final selectedCitizenProvider =
    AutoDisposeNotifierProvider<SelectedCitizen, int>.internal(
  SelectedCitizen.new,
  name: r'selectedCitizenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCitizenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCitizen = AutoDisposeNotifier<int>;
String _$selectedIndependentHash() =>
    r'9791f1c5e9ec036dc058d2960534b606be84f28f';

/// See also [SelectedIndependent].
@ProviderFor(SelectedIndependent)
final selectedIndependentProvider =
    AutoDisposeNotifierProvider<SelectedIndependent, int>.internal(
  SelectedIndependent.new,
  name: r'selectedIndependentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedIndependentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedIndependent = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
