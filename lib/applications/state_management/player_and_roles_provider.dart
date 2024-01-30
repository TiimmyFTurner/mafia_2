import 'dart:convert';

import 'package:mafia_2/applications/state_management/shared_preferences_provider.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';
import 'package:mafia_2/domain/data_models/role_model.dart';
import 'package:mafia_2/infrastructure/data/roles_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'player_and_roles_provider.g.dart';

// **************************************************************************
// Limit Lock
// **************************************************************************
@Riverpod(keepAlive: true)
class LimitLock extends _$LimitLock {
  late SharedPreferences _prefs;

  @override
  bool build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    bool status = _prefs.getBool('limitLock') ?? true;
    return status;
  }

  void toggle() {
    state = !state;
    if (state & ref.read(starRoleProvider) == true) {
      ref.read(starRoleProvider.notifier).toggle();
    }
    _prefs.setBool('limitLock', state);
  }
}

// **************************************************************************
// Star Role
// **************************************************************************
@Riverpod(keepAlive: true)
class StarRole extends _$StarRole {
  late SharedPreferences _prefs;

  @override
  bool build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    bool status = _prefs.getBool('starRole') ?? false;
    return status;
  }

  void toggle() {
    state = !state;
    _prefs.setBool('starRole', state);
  }
}

// **************************************************************************
// PlayerNames
// **************************************************************************
@Riverpod(keepAlive: true)
class PlayerNames extends _$PlayerNames {
  late SharedPreferences _prefs;

  @override
  List<String> build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    List<String> players = _prefs.getStringList('lastPlayers') ?? [];
    return players;
  }

  void addPlayer(String name) {
    state = [...state, name];
    _prefs.setStringList('lastPlayers', state);
  }

  void removePlayer(String name) {
    state = [
      for (final player in state)
        if (player != name) player,
    ];
    _prefs.setStringList('lastPlayers', state);
  }

// void recoverLastPlayers() {
//   List<String>? lastPlayers = _prefs.getStringList('lastPlayers');
//   if (lastPlayers != null) state = lastPlayers;
// }
}

// **************************************************************************
// Mafias
// **************************************************************************
@Riverpod(keepAlive: true)
class Mafias extends _$Mafias {
  @override
  List<Role> build() {
    return Roles().mafia;
  }

  void addMafia(Role role) {
    state = [...state, role];
  }

  void removeMafia(Role role) {
    state = [
      for (final item in state)
        if (item != role) item,
    ];
  }
}

// **************************************************************************
// Citizens
// **************************************************************************
@Riverpod(keepAlive: true)
class Citizens extends _$Citizens {
  @override
  List<Role> build() {
    return Roles().citizen;
  }

  void addCitizen(Role role) {
    state = [...state, role];
  }

  void removeCitizen(Role role) {
    state = [
      for (final item in state)
        if (item != role) item,
    ];
  }
}

// **************************************************************************
// Independents
// **************************************************************************
@Riverpod(keepAlive: true)
class Independents extends _$Independents {
  @override
  List<Role> build() {
    return Roles().independent;
  }

  void addIndependent(Role role) {
    state = [...state, role];
  }

  void removeIndependent(Role role) {
    state = [
      for (final item in state)
        if (item != role) item,
    ];
  }
}

// **************************************************************************
// SelectedMafia
// **************************************************************************
@Riverpod(keepAlive: true)
class SelectedMafia extends _$SelectedMafia {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;
}

// **************************************************************************
// SelectedCitizen
// **************************************************************************
@Riverpod(keepAlive: true)
class SelectedCitizen extends _$SelectedCitizen {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;
}

// **************************************************************************
// SelectedIndependent
// **************************************************************************
@Riverpod(keepAlive: true)
class SelectedIndependent extends _$SelectedIndependent {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;
}

// **************************************************************************
// Alive
// **************************************************************************
@Riverpod(keepAlive: true)
class Alive extends _$SelectedIndependent {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;
}

// **************************************************************************
// voteToJudge
// **************************************************************************
@riverpod
int voteToJudge(VoteToJudgeRef ref) {
  final alive = ref.watch(aliveProvider);
  return alive ~/ 2;
}

// **************************************************************************
// voteToDead
// **************************************************************************
@riverpod
int voteToDead(VoteToDeadRef ref) {
  final alive = ref.watch(aliveProvider);
  return (alive ~/ 2) + 1;
}

// **************************************************************************
// Day
// **************************************************************************
@Riverpod(keepAlive: true)
class Day extends _$Day {
  @override
  int build() => 1;

  void increment() => state++;
}

// **************************************************************************
// Night
// **************************************************************************
@Riverpod(keepAlive: true)
class Night extends _$Night {
  @override
  int build() => 1;

  void increment() => state++;
}

// **************************************************************************
// Custom Role
// **************************************************************************
@Riverpod(keepAlive: true)
class CustomRole extends _$CustomRole {
  late SharedPreferences _prefs;

  @override
  List<Role> build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return [];
  }

  void recoverRoles() {
    final storedString = _prefs.getString('custom_roles');
    if (storedString != null) {
      final individualJsons = storedString.split('|');
      final deserializedList =
          individualJsons.map((json) => jsonDecode(json)).toList();
      List<Role> rolesList = [];
      for (final item in deserializedList) {
        Role role = Role.fromJson(item);
        role.type == 'M'
            ? ref.read(mafiasProvider.notifier).addMafia(role)
            : role.type == 'C'
                ? ref.read(citizensProvider.notifier).addCitizen(role)
                : ref.read(independentsProvider.notifier).addIndependent(role);
        rolesList.add(role);
      }
      state = rolesList;
    }
  }

  void addCustomRole(Role role) {
    state = [...state, role];
    role.type == 'M'
        ? ref.read(mafiasProvider.notifier).addMafia(role)
        : role.type == 'C'
            ? ref.read(citizensProvider.notifier).addCitizen(role)
            : ref.read(independentsProvider.notifier).addIndependent(role);
    _saveSharedPreferences();
  }

  void removeCustomRole(Role role) {
    state = [
      for (final item in state)
        if (item.name != role.name) item,
    ];
    role.type == 'M'
        ? ref.read(mafiasProvider.notifier).removeMafia(role)
        : role.type == 'C'
            ? ref.read(citizensProvider.notifier).removeCitizen(role)
            : ref.read(independentsProvider.notifier).removeIndependent(role);
    ref.read(selectedRolesProvider.notifier).removeRole(role);
    _saveSharedPreferences();
  }

  void _saveSharedPreferences() {
    if (state.isNotEmpty) {
      final jsonList = state.map((role) => jsonEncode(role.toJson()));
      final joinedString = jsonList.join('|');
      _prefs.setString('custom_roles', joinedString);
    } else {
      _prefs.remove('custom_roles');
    }
  }
}

// **************************************************************************
// SelectedRoles
// **************************************************************************
@Riverpod(keepAlive: true)
class SelectedRoles extends _$SelectedRoles {
  late SharedPreferences _prefs;

  @override
  List<Role> build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return [];
  }

  void removeRole(Role role) {
    if (state.contains(role)) {
      state = [
        for (final item in state)
          if (item.name != role.name) item,
      ];
      if (role.type == 'M') {
        ref.read(mafiasProvider.notifier).addMafia(role);
        ref.read(selectedMafiaProvider.notifier).decrement();
      } else if (role.type == 'C') {
        ref.read(citizensProvider.notifier).addCitizen(role);
        ref.read(selectedCitizenProvider.notifier).decrement();
      } else {
        ref.read(independentsProvider.notifier).addIndependent(role);
        ref.read(selectedCitizenProvider.notifier).decrement();
        ref.read(selectedIndependentProvider.notifier).decrement();
      }
    }
  }

  void addRole(Role role) {
    List players = ref.read(playerNamesProvider);
    int selectedMafia = ref.read(selectedMafiaProvider);
    int selectedCitizen = ref.read(selectedCitizenProvider);
    if (players.length > state.length) {
      if (ref.read(limitLockProvider)) {
        if (role.type == 'M' && selectedMafia < players.length ~/ 3) {
          state = [...state, role];
          ref.read(selectedMafiaProvider.notifier).increment();
          ref.read(mafiasProvider.notifier).removeMafia(role);
        } else if (role.type == 'C' &&
            selectedCitizen < players.length - (players.length ~/ 3)) {
          state = [...state, role];
          ref.read(selectedCitizenProvider.notifier).increment();
          ref.read(citizensProvider.notifier).removeCitizen(role);
        } else if (role.type == "I" &&
            selectedCitizen < players.length - (players.length ~/ 3)) {
          state = [...state, role];
          ref.read(selectedCitizenProvider.notifier).increment();
          ref.read(selectedIndependentProvider.notifier).increment();
          ref.read(independentsProvider.notifier).removeIndependent(role);
        }
      } else {
        state = [...state, role];
        if (role.type == 'M') {
          ref.read(selectedMafiaProvider.notifier).increment();
        } else {
          ref.read(selectedCitizenProvider.notifier).increment();
          if (role.type == 'I') {
            ref.read(selectedIndependentProvider.notifier).increment();
          }
        }
        role.type == 'M'
            ? ref.read(mafiasProvider.notifier).removeMafia(role)
            : role.type == 'C'
                ? ref.read(citizensProvider.notifier).removeCitizen(role)
                : ref
                    .read(independentsProvider.notifier)
                    .removeIndependent(role);

        if (ref.read(starRoleProvider) && !role.name.contains('⭐⭐⭐')) {
          Role newStarRole = role.copyWith();
          newStarRole.name += newStarRole.name.contains('⭐') ? '⭐' : ' ⭐';
          //check if the new star role is not already created
          if (!state.any((item) => item.name == newStarRole.name)) {
            if (newStarRole.type == 'M' &&
                !ref
                    .read(mafiasProvider)
                    .any((item) => item.name == newStarRole.name)) {
              ref.read(mafiasProvider.notifier).addMafia(newStarRole);
            } else if (newStarRole.type == 'C' &&
                !ref
                    .read(citizensProvider)
                    .any((item) => item.name == newStarRole.name)) {
              ref.read(citizensProvider.notifier).addCitizen(newStarRole);
            } else if (newStarRole.type == 'I' &&
                !ref
                    .read(independentsProvider)
                    .any((item) => item.name == newStarRole.name)) {
              ref
                  .read(independentsProvider.notifier)
                  .addIndependent(newStarRole);
            }
          }
        }
      }
    }
  }

  void saveRoles() async {
    await _prefs.setStringList('lastRoles', state.map((e) => e.name).toList());
  }

  void recoverLastRoles() {
    Roles roles = Roles();
    List<String>? lastRoles = _prefs.getStringList('lastRoles');
    if (lastRoles != null) {
      for (Role selectedRole in List.from(state)) {
        if (!selectedRole.name.contains('⭐')) removeRole(selectedRole);
      }
      for (String role in lastRoles) {
        if (!role.contains('⭐')) addRole(roles.find(role));
      }
    }
  }
}

// **************************************************************************
// Players
// **************************************************************************
@Riverpod(keepAlive: true)
class Players extends _$Players {
  @override
  List<Player> build() {
    return [];
  }

  setPlayers() async {
    List playerNames = ref.read(playerNamesProvider);
    int selectedCitizenCount = ref.read(selectedCitizenProvider),
        selectedMafiaCount = ref.read(selectedMafiaProvider),
        selectedRolesCount = ref.read(selectedRolesProvider).length;

    if (playerNames.length != selectedRolesCount) {
      while (selectedMafiaCount < playerNames.length ~/ 3 &&
          selectedRolesCount < playerNames.length) {
        ref.read(selectedRolesProvider.notifier).addRole(
              Role(
                  name: 'مافیا',
                  type: 'M',
                  order: 19,
                  job: "یک مافیای ساده که عملکرد خاصی ندارد"),
            );
        selectedMafiaCount++;
        selectedRolesCount++;
      }
      while (selectedCitizenCount <
              playerNames.length - (playerNames.length ~/ 3) &&
          selectedRolesCount < playerNames.length) {
        ref.read(selectedRolesProvider.notifier).addRole(
              Role(
                  name: 'شهروند',
                  type: 'C',
                  order: 49,
                  job: "شهروند عادی ک در شب نقشی ندارد"),
            );
        selectedCitizenCount++;
        selectedRolesCount++;
      }
    }
    if (playerNames.length == selectedRolesCount) {
      state = [];
      List selectedRoles = ref.watch(selectedRolesProvider);
      playerNames.shuffle();
      selectedRoles.shuffle();
      for (var i = 0; i < playerNames.length; i++) {
        state = [
          ...state,
          Player(
              name: playerNames[i],
              status: 'alive',
              role: selectedRoles[i])
        ];
      }
    }
  }

  void sortPlayers(){
    List<Player> temp = [...state];
    temp.sort((p1, p2) => p1.role.order.compareTo(p2.role.order));
    state = temp;
  }

  void silentPlayer(String playerName) {
    state = [
      for (final player in state)
        if (player.name == playerName)
          player.copyWith(
              status: player.status == 'silent' ? 'alive' : 'silent')
        else
          player
    ];
  }

  void killPlayer(String playerName) {
    state = [
      for (final player in state)
        if (player.name == playerName)
          player.copyWith(status: player.status != 'dead' ? 'dead' : 'alive')
        else
          player
    ];
  }

  void judgePlayer(String playerName) {
    state = [
      for (final player in state)
        if (player.name == playerName)
          player.copyWith(status: player.status == 'judge' ? 'alive' : 'judge')
        else
          player
    ];
  }
}

// **************************************************************************
// winnerCheck
// **************************************************************************
@riverpod
String winnerCheck(WinnerCheckRef ref) {
  int tAlive = 0, tAliveCitizen = 0, tAliveMafia = 0, tAliveIndependent = 0;
  ref.watch(playersProvider).forEach((element) {
    if (element.status != 'dead') {
      tAlive++;
      element.role.type == 'M'
          ? tAliveMafia++
          : element.role.type == 'C'
              ? tAliveCitizen++
              : tAliveIndependent++;
    }
  });
  if (tAliveMafia >= tAliveCitizen) {
    return 'M';
  } else if (tAlive < 4 && tAliveIndependent > 0) {
    return 'I';
  } else if (tAliveMafia == 0) {
    return 'C';
  }
  return '';
}

//TODO:IMPLEMENT THESE IN RIVERPOD

// newGame() {
// Roles roles = Roles();
// _selectedRoles = [];
// _playersWithRole = [];
// _playersWithRoleFoShow = [];
// _selectedCitizen = 0;
// _selectedMafia = 0;
// _selectedIndependent = 0;
// _mafia = roles.mafia;
// _citizen = roles.citizen;
// _independent = roles.independent;
// }

//
//
// playGame() {
//   _day = 1;
//   _night = 1;
//   _sortPlayer();
// }
//
// startDay() {
//   _night++;
// }
//
// startVoting() {
//   if (_day > 1) _playersWithRole.shuffle();
//   _alives = 0;
//   _playersWithRole.forEach((element) {
//     if (element.status != 'dead') _alives++;
//   });
//   _day++;
// }
//
// startNight() {
//   _sortPlayer();
// }
//
// _sortPlayer() =>
//     _playersWithRole.sort((p1, p2) => p1.role.order.compareTo(p2.role.order));
