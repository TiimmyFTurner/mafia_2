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
@riverpod
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
@riverpod
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
@riverpod
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
@riverpod
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
        if (item.name != role.name) item,
    ];
  }
}

// **************************************************************************
// Citizens
// **************************************************************************
@riverpod
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
        if (item.name != role.name) item,
    ];
  }
}

// **************************************************************************
// Independents
// **************************************************************************
@riverpod
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
        if (item.name != role.name) item,
    ];
  }
}

// **************************************************************************
// SelectedMafia
// **************************************************************************
@riverpod
class SelectedMafia extends _$SelectedMafia {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;
}

// **************************************************************************
// SelectedCitizen
// **************************************************************************
@riverpod
class SelectedCitizen extends _$SelectedCitizen {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;
}

// **************************************************************************
// SelectedIndependent
// **************************************************************************
@riverpod
class SelectedIndependent extends _$SelectedIndependent {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;
}

// **************************************************************************
// Alive
// **************************************************************************
@riverpod
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
@riverpod
class Day extends _$Day {
  @override
  int build() => 0;

  void increment() => state++;
}

// **************************************************************************
// Night
// **************************************************************************
@riverpod
class Night extends _$Night {
  @override
  int build() => 0;

  void increment() => state++;
}

// **************************************************************************
// Custom Role
// **************************************************************************
@riverpod
class CustomRole extends _$CustomRole {
  late SharedPreferences _prefs;

  @override
  List<Role> build() {
    List<Role> roles;
    _prefs = ref.watch(sharedPreferencesProvider);
    dynamic temp = _prefs.getString('customRoles');
    if (temp.isNotEmpty) {
      temp = jsonDecode(temp);
      roles = temp.map((e) => Role.fromJson(e)).toList();
      for (var element in roles) {
        element.type == 'M'
            ? ref.read(mafiasProvider.notifier).addMafia(element)
            : element.type == 'C'
                ? ref.read(citizensProvider.notifier).addCitizen(element)
                : ref
                    .read(independentsProvider.notifier)
                    .addIndependent(element);
      }
      return roles;
    } else {
      return [];
    }
  }

  void addCustomRole(Role role) {
    state = [...state, role];
    role.type == 'M'
        ? ref.read(mafiasProvider.notifier).addMafia(role)
        : role.type == 'C'
            ? ref.read(citizensProvider.notifier).addCitizen(role)
            : ref.read(independentsProvider.notifier).addIndependent(role);
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
    //TODO:Fix when selectedRoles provider is created
    // _selectedRoles.remove(role);
  }
}

// **************************************************************************
// SelectedRoles
// **************************************************************************
@riverpod
class SelectedRoles extends _$SelectedRoles {
  late SharedPreferences _prefs;

  @override
  List<Role> build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return [];
  }

  void removeRole(Role role) {
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
@riverpod
class Players extends _$Players {
  @override
  List<Player> build() {
    return [];
  }

  setPlayers() {
    List playerNames = ref.watch(playerNamesProvider);

    if (playerNames.length != ref.watch(selectedRolesProvider).length) {
      while (ref.read(selectedMafiaProvider) < playerNames.length ~/ 3 &&
          ref.watch(selectedRolesProvider).length < playerNames.length) {
        ref.read(selectedRolesProvider.notifier).addRole(
              Role(
                  name: 'مافیا',
                  type: 'M',
                  order: 19,
                  job: "یک مافیای ساده که عملکرد خاصی ندارد"),
            );
        ref.read(selectedMafiaProvider.notifier).increment();
      }
      while (ref.watch(selectedCitizenProvider) <
              playerNames.length - (playerNames.length ~/ 3) &&
          ref.watch(selectedRolesProvider).length < playerNames.length) {
        ref.read(selectedRolesProvider.notifier).addRole(
              Role(
                  name: 'شهروند',
                  type: 'C',
                  order: 49,
                  job: "شهروند عادی ک در شب نقشی ندارد"),
            );
        ref.read(selectedCitizenProvider.notifier).increment();
      }
    }
    if (playerNames.length == ref.watch(selectedRolesProvider).length) {
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
              role: ref.watch(selectedRolesProvider)[i])
        ];
      }
      // _playersWithRoleFoShow = List.from(_playersWithRole);
    }
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
//_mafia = roles.mafia;
// _citizen = roles.citizen;
// _independent = roles.independent;
// }

// saveRoles() async {
//   await _prefs.setStringList(
//       'lastRoles', _selectedRoles.map((e) => e.name).toList());
// }
// recoverLastRoles() {
//   Roles roles = Roles();
//   var lastRoles = _prefs.getStringList('lastRoles');
//   if (lastRoles?.length != 0) {
//     for (Role _selectedRole in List.from(_selectedRoles))
//       if (!_selectedRole.name.contains('⭐')) removeRole = _selectedRole;
//     for (String role in lastRoles!)
//       if (!role.contains('⭐')) addRole = roles.find(role);
//   }
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
