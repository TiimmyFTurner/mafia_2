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
String _$limitLockHash() => r'a50ee328933be0694e3c8567e19bd83093ac7904';

/// See also [LimitLock].
@ProviderFor(LimitLock)
final limitLockProvider = NotifierProvider<LimitLock, bool>.internal(
  LimitLock.new,
  name: r'limitLockProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$limitLockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LimitLock = Notifier<bool>;
String _$starRoleHash() => r'c483c569af222f7d052601e42454039069940b2c';

/// See also [StarRole].
@ProviderFor(StarRole)
final starRoleProvider = NotifierProvider<StarRole, bool>.internal(
  StarRole.new,
  name: r'starRoleProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$starRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StarRole = Notifier<bool>;
String _$playerNamesHash() => r'ec0d1768c42bee696c513ad45a7583cbc6241756';

/// See also [PlayerNames].
@ProviderFor(PlayerNames)
final playerNamesProvider =
    NotifierProvider<PlayerNames, List<String>>.internal(
  PlayerNames.new,
  name: r'playerNamesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playerNamesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PlayerNames = Notifier<List<String>>;
String _$mafiasHash() => r'd653d79f12f6bcecf56d7547e05d68802ceb7886';

/// See also [Mafias].
@ProviderFor(Mafias)
final mafiasProvider = NotifierProvider<Mafias, List<Role>>.internal(
  Mafias.new,
  name: r'mafiasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mafiasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Mafias = Notifier<List<Role>>;
String _$citizensHash() => r'9de16880c0fbfa3610bf7bbb5b1eb8500814c90c';

/// See also [Citizens].
@ProviderFor(Citizens)
final citizensProvider = NotifierProvider<Citizens, List<Role>>.internal(
  Citizens.new,
  name: r'citizensProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$citizensHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Citizens = Notifier<List<Role>>;
String _$independentsHash() => r'b24f26df00c7e1e24d7fb10a21521799c6d68b37';

/// See also [Independents].
@ProviderFor(Independents)
final independentsProvider =
    NotifierProvider<Independents, List<Role>>.internal(
  Independents.new,
  name: r'independentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$independentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Independents = Notifier<List<Role>>;
String _$selectedMafiaHash() => r'bdf809aedbad9c978d3fd5c55acb26c04c7bf2d1';

/// See also [SelectedMafia].
@ProviderFor(SelectedMafia)
final selectedMafiaProvider = NotifierProvider<SelectedMafia, int>.internal(
  SelectedMafia.new,
  name: r'selectedMafiaProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedMafiaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedMafia = Notifier<int>;
String _$selectedCitizenHash() => r'52c37a6f097588556607d3d92c5db7b5cd368e61';

/// See also [SelectedCitizen].
@ProviderFor(SelectedCitizen)
final selectedCitizenProvider = NotifierProvider<SelectedCitizen, int>.internal(
  SelectedCitizen.new,
  name: r'selectedCitizenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCitizenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCitizen = Notifier<int>;
String _$selectedIndependentHash() =>
    r'9ed78a9c5dfa081ff58091f7439bff236c988ceb';

/// See also [SelectedIndependent].
@ProviderFor(SelectedIndependent)
final selectedIndependentProvider =
    NotifierProvider<SelectedIndependent, int>.internal(
  SelectedIndependent.new,
  name: r'selectedIndependentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedIndependentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedIndependent = Notifier<int>;
String _$aliveHash() => r'0f251a30d1ddeca5e2885e620abd34ff0213dc5e';

/// See also [Alive].
@ProviderFor(Alive)
final aliveProvider = NotifierProvider<Alive, int>.internal(
  Alive.new,
  name: r'aliveProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$aliveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Alive = Notifier<int>;
String _$dayHash() => r'1a50347b7b4225b801e832dd89d66a009fd623e3';

/// See also [Day].
@ProviderFor(Day)
final dayProvider = NotifierProvider<Day, int>.internal(
  Day.new,
  name: r'dayProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dayHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Day = Notifier<int>;
String _$nightHash() => r'e050672bd80b1fe4096d1b438966bf222060b046';

/// See also [Night].
@ProviderFor(Night)
final nightProvider = NotifierProvider<Night, int>.internal(
  Night.new,
  name: r'nightProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nightHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Night = Notifier<int>;
String _$customRoleHash() => r'b63ec584572e0acf710aaed13b02d5c98d43a281';

/// See also [CustomRole].
@ProviderFor(CustomRole)
final customRoleProvider = NotifierProvider<CustomRole, List<Role>>.internal(
  CustomRole.new,
  name: r'customRoleProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$customRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomRole = Notifier<List<Role>>;
String _$selectedRolesHash() => r'94ee9a6e44b27f4ec6d1763046458a32b917f8f5';

/// See also [SelectedRoles].
@ProviderFor(SelectedRoles)
final selectedRolesProvider =
    NotifierProvider<SelectedRoles, List<Role>>.internal(
  SelectedRoles.new,
  name: r'selectedRolesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedRolesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedRoles = Notifier<List<Role>>;
String _$playersHash() => r'16354ddaae69201b7c7b082fd4bae5b01c539104';

/// See also [Players].
@ProviderFor(Players)
final playersProvider = NotifierProvider<Players, List<Player>>.internal(
  Players.new,
  name: r'playersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Players = Notifier<List<Player>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
