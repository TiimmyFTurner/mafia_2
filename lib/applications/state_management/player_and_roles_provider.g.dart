// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_and_roles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$voteToJudgeHash() => r'4d670f4972edfbf110e9f5885a4eadd860623a90';

/// See also [voteToJudge].
@ProviderFor(voteToJudge)
final voteToJudgeProvider = AutoDisposeProvider<int>.internal(
  voteToJudge,
  name: r'voteToJudgeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$voteToJudgeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VoteToJudgeRef = AutoDisposeProviderRef<int>;
String _$voteToDeadHash() => r'656c11294cfadc90d5e9cb2cc48ef6198fc04f46';

/// See also [voteToDead].
@ProviderFor(voteToDead)
final voteToDeadProvider = AutoDisposeProvider<int>.internal(
  voteToDead,
  name: r'voteToDeadProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$voteToDeadHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VoteToDeadRef = AutoDisposeProviderRef<int>;
String _$winnerCheckHash() => r'87b0dbe05f396231979597e2e143d0a5b330999d';

/// See also [winnerCheck].
@ProviderFor(winnerCheck)
final winnerCheckProvider = AutoDisposeProvider<String>.internal(
  winnerCheck,
  name: r'winnerCheckProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$winnerCheckHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WinnerCheckRef = AutoDisposeProviderRef<String>;
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
String _$aliveHash() => r'17b833e538ddbde5c62c814c8a512df9f5bd6bd0';

/// See also [Alive].
@ProviderFor(Alive)
final aliveProvider = AutoDisposeNotifierProvider<Alive, int>.internal(
  Alive.new,
  name: r'aliveProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$aliveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Alive = AutoDisposeNotifier<int>;
String _$dayHash() => r'772101bf80179d35d8d3cd2bdc4df0fc45ebd3b9';

/// See also [Day].
@ProviderFor(Day)
final dayProvider = AutoDisposeNotifierProvider<Day, int>.internal(
  Day.new,
  name: r'dayProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dayHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Day = AutoDisposeNotifier<int>;
String _$nightHash() => r'8f7bb085b106f074f1e7c9f5e8ba4cc0f2e73f59';

/// See also [Night].
@ProviderFor(Night)
final nightProvider = AutoDisposeNotifierProvider<Night, int>.internal(
  Night.new,
  name: r'nightProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nightHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Night = AutoDisposeNotifier<int>;
String _$customRoleHash() => r'08870a33b1aa51753761433aaf5eb204065f6600';

/// See also [CustomRole].
@ProviderFor(CustomRole)
final customRoleProvider =
    AutoDisposeNotifierProvider<CustomRole, List<Role>>.internal(
  CustomRole.new,
  name: r'customRoleProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$customRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomRole = AutoDisposeNotifier<List<Role>>;
String _$selectedRolesHash() => r'fadf20ed06bc7de9cb90e309b38199f6a0f214ef';

/// See also [SelectedRoles].
@ProviderFor(SelectedRoles)
final selectedRolesProvider =
    AutoDisposeNotifierProvider<SelectedRoles, List<Role>>.internal(
  SelectedRoles.new,
  name: r'selectedRolesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedRolesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedRoles = AutoDisposeNotifier<List<Role>>;
String _$playersHash() => r'8a23a76c70db9213773bc84191a2f0928d1d627c';

/// See also [Players].
@ProviderFor(Players)
final playersProvider =
    AutoDisposeNotifierProvider<Players, List<Player>>.internal(
  Players.new,
  name: r'playersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Players = AutoDisposeNotifier<List<Player>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
