import 'dart:convert';

import 'package:mafia_2/domain/data_models/player_model.dart';
import 'package:mafia_2/domain/data_models/role_model.dart';
import 'package:mafia_2/infrastructure/data/roles_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'player_and_roles_provider.g.dart';

@riverpod
class RolesNPlayers extends _$RolesNPlayers {

  @override
  List<dynamic> build() {
    return [];
  }

  List<String> _players = [];
  late List<Role> _selectedRoles;
  late List<Role> _mafia;
  late List<Role> _citizen;
  late List<Role> _independent;
  late int _selectedMafia;
  late int _selectedCitizen;
  late int _selectedIndependent;
  late List<Player> _playersWithRole;
  late List<Player> _playersWithRoleFoShow;
  late int _day, _night;
  late int _alives;
  late SharedPreferences _prefs;
  dynamic _limitLock = false;
  late bool _starRole;
  late List _customRoles;
  dynamic _customRolesTemp;
  get alive => _alives;
  get voteToJudge => _alives ~/ 2;
  get voteToDead => (_alives ~/ 2) + 1;
  get day => _day;
  get night => _night;
  get playersWithRolesFoShow => _playersWithRoleFoShow;
  get playersWithRoles => _playersWithRole;
  get players => _players;
  // get limitLock => _limitLock;
  get mafia => _mafia;
  get citizen => _citizen;
  get independent => _independent;
  get selectedRoles => _selectedRoles;
  // get starRole => _starRole;
  get customRoles => _customRoles;
  get selectedMafia => _selectedMafia;
  get selectedCitizen => _selectedCitizen;
  get selectedIndependent => _selectedIndependent;

  newGame() {
    Roles roles = Roles();
    _selectedRoles = [];
    _playersWithRole = [];
    _playersWithRoleFoShow = [];
    _selectedCitizen = 0;
    _selectedMafia = 0;
    _selectedIndependent = 0;
    _mafia = roles.mafia;
    _citizen = roles.citizen;
    _independent = roles.independent;
  }

  initRNPSetting() async {
    newGame();
    _prefs = await SharedPreferences.getInstance();
    _limitLock = (_prefs.getBool('limitLock') ?? true)
        ? _limitLock = true
        : _limitLock = false;
    _starRole = (_prefs.getBool('starRole') ?? false)
        ? _starRole = true
        : _starRole = false;
    _customRolesTemp = _prefs.getString('customRoles') ?? 'Empty';
    if (_customRolesTemp != 'Empty') {
      _customRolesTemp = jsonDecode(_customRolesTemp);
      _customRoles = _customRolesTemp.map((e) => Role.fromJson(e)).toList();
      _customRoles.forEach((element) {
        element.type == 'M'
            ? _mafia.add(element)
            : element.type == 'C'
            ? _citizen.add(element)
            : _independent.add(element);
      });
    } else
      _customRoles = [];
    recoverLastPlayers();
      }

  set addCustomRole(Role role) {
    _customRoles.add(role);
    role.type == 'M'
        ? _mafia.add(role)
        : role.type == 'C'
        ? _citizen.add(role)
        : _independent.add(role);
      }

  set removeCustomRole(Role role) {
    _customRoles.remove(role);
    role.type == 'M'
        ? _mafia.removeWhere((e) => e.name == role.name)
        : role.type == 'C'
        ? _citizen.removeWhere((e) => e.name == role.name)
        : _independent.removeWhere((e) => e.name == role.name);
    _selectedRoles.remove(role);
      }

  set removeRole(Role role) {
    _selectedRoles.remove(role);
    if (role.type == 'M') {
      _mafia.add(role);
      _selectedMafia--;
    } else if (role.type == 'C') {
      _selectedCitizen--;
      _citizen.add(role);
    } else {
      _selectedCitizen--;
      _selectedIndependent--;
      _independent.add(role);
    }
      }

  set silentPlayer(index) {
    _playersWithRole[index].status =
    _playersWithRole[index].status == 'silent' ? 'alive' : 'silent';
      }

  set killPlayer(index) {
    _playersWithRole[index].status =
    _playersWithRole[index].status != 'dead' ? 'dead' : 'alive';
      }

  set judgePlayer(index) {
    _playersWithRole[index].status =
    _playersWithRole[index].status == 'judge' ? 'alive' : 'judge';
      }

  set limitLock(bool status) {
    _limitLock = status;
    if (status == true) _starRole = false;
    _prefs.setBool('limitLock', _limitLock);
      }

  set starRole(bool status) {
    _starRole = status;
    _prefs.setBool('starRole', _starRole);
      }

  set addPlayer(String name) {
    _players.add(name);
      }

  set removePlayer(String name) {
    _players.remove(name);
      }

  set addRole(Role role) {
    if (_players.length > _selectedRoles.length) {
      if (_limitLock) {
        if (role.type == 'M' && _selectedMafia < _players.length ~/ 3) {
          _selectedRoles.add(role);
          _selectedMafia++;
          _mafia.removeWhere((e) => e.name == role.name);
        } else if (role.type == 'C' &&
            _selectedCitizen < _players.length - (_players.length ~/ 3)) {
          _selectedRoles.add(role);
          _selectedCitizen++;
          _citizen.removeWhere((e) => e.name == role.name);
        } else if (role.type == "I" &&
            _selectedCitizen < _players.length - (_players.length ~/ 3)) {
          _selectedRoles.add(role);
          _selectedCitizen++;
          _selectedIndependent++;
          _independent.removeWhere((e) => e.name == role.name);
        }
      } else {
        _selectedRoles.add(role);
        if (role.type == 'M')
          _selectedMafia++;
        else {
          _selectedCitizen++;
          if (role.type == 'I') _selectedIndependent++;
        }
        role.type == 'M'
            ? _mafia.removeWhere((e) => e.name == role.name)
            : role.type == 'C'
            ? _citizen.removeWhere((e) => e.name == role.name)
            : _independent.removeWhere((e) => e.name == role.name);

        if (_starRole && !role.name.contains('⭐⭐⭐')) {
          Role newStarRole = role.copyWith();
          newStarRole.name += newStarRole.name.contains('⭐') ? '⭐' : ' ⭐';
          //check if the new star role is not alredy created
          if (!_selectedRoles.any((item) => item.name == newStarRole.name)) {
            if (newStarRole.type == 'M' &&
                !_mafia.any((item) => item.name == newStarRole.name)) {
              mafia.add(newStarRole);
            } else if (newStarRole.type == 'C' &&
                !_citizen.any((item) => item.name == newStarRole.name)) {
              _citizen.add(newStarRole);
            } else if (newStarRole.type == 'I' &&
                !_independent.any((item) => item.name == newStarRole.name)) {
              _independent.add(newStarRole);
            }
          }
        }
      }
          }
  }

  saveCustomRoles() {
    _customRoles == null
        ? _customRolesTemp = null
        : _customRolesTemp = _customRoles.map((e) => e.toMap()).toList();
    _prefs.setString('customRoles', jsonEncode(_customRolesTemp));
  }

  setPlayers() {
    if (_players.length != _selectedRoles.length) {
      while (_selectedMafia < _players.length ~/ 3 &&
          _selectedRoles.length < _players.length) {
        _selectedRoles.add(
          Role(
              name: 'مافیا',
              type: 'M',
              order: 19,
              job: "یک مافیای ساده که عملکرد خاصی ندارد"),
        );
        _selectedMafia++;
      }
      while (_selectedCitizen < _players.length - (_players.length ~/ 3) &&
          _selectedRoles.length < _players.length) {
        _selectedRoles.add(
          Role(
              name: 'شهروند',
              type: 'C',
              order: 49,
              job: "شهروند عادی ک در شب نقشی ندارد"),
        );
        _selectedCitizen++;
      }
    }
    if (_players.length == _selectedRoles.length) {
      _playersWithRole.clear();
      _players.shuffle();
      _selectedRoles.shuffle();
      for (var i = 0; i < _players.length; i++) {
        _playersWithRole.add(Player(
            name: _players[i], status: 'alive', role: _selectedRoles[i]));
      }
      _playersWithRoleFoShow = List.from(_playersWithRole);
          }
  }

  recoverLastRoles() {
    Roles roles = Roles();
    var _lastRoles = _prefs.getStringList('lastRoles');
    if (_lastRoles?.length != 0) {
      for (Role _selectedRole in List.from(_selectedRoles))
        if (!_selectedRole.name.contains('⭐')) removeRole = _selectedRole;
      for (String role in _lastRoles!)
        if (!role.contains('⭐')) addRole = roles.find(role);
    }
      }

  saveRoles() async {
    await _prefs.setStringList(
        'lastRoles', _selectedRoles.map((e) => e.name).toList());
  }

  savePlayers() async => await _prefs.setStringList('lastPlayers', _players);

  bool recoverLastPlayers() {
    _players = _prefs.getStringList('lastPlayers') ?? [];
        return _players.isNotEmpty;
  }

  playGame() {
    _day = 1;
    _night = 1;
    _sortPlayer();
      }

  startDay() {
    _night++;
      }

  startVoting() {
    if (_day > 1) _playersWithRole.shuffle();
    _alives = 0;
    _playersWithRole.forEach((element) {
      if (element.status != 'dead') _alives++;
    });
    _day++;
      }

  startNight() {
    _sortPlayer();
  }

  _sortPlayer() =>
      _playersWithRole.sort((p1, p2) => p1.role.order.compareTo(p2.role.order));

  String winnerCheck() {
    int _tAlive = 0,
        _tAliveCitizen = 0,
        _tAliveMafia = 0,
        _tAliveIndependent = 0;
    _playersWithRole.forEach((element) {
      if (element.status != 'dead') {
        _tAlive++;
        element.role.type == 'M'
            ? _tAliveMafia++
            : element.role.type == 'C'
            ? _tAliveCitizen++
            : _tAliveIndependent++;
      }
    });
    if (_tAliveMafia >= _tAliveCitizen)
      return 'M';
    else if (_tAlive < 4 && _tAliveIndependent > 0)
      return 'I';
    else if (_tAliveMafia == 0)
      return 'C';
    else
      return '';
  }
}
