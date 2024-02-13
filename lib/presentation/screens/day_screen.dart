import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:mafia_2/applications/state_management/note_provider.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';
import 'package:mafia_2/infrastructure/router/routes_constant.dart';
import 'package:mafia_2/presentation/helpers/lock_timer.dart';
import 'package:mafia_2/presentation/helpers/persian_number_helper.dart';
import 'package:mafia_2/presentation/widgets/in_game_app_bar_widget.dart';
import 'package:mafia_2/presentation/widgets/player_list_item_day.dart';
import 'package:audioplayers/audioplayers.dart';

class DayScreen extends ConsumerStatefulWidget {
  const DayScreen({super.key});

  @override
  DayScreenState createState() => DayScreenState();
}

Timer? _timer;
int _current = 30, _timerTime = 30;

List<int> _timerItems = [180, 120, 90, 60, 30, 15];

class DayScreenState extends ConsumerState<DayScreen> {
  late int dayN;

  @override
  void initState() {
    lockTimer(context);
    dayN = ref.read(dayProvider);
    super.initState();
    Future.delayed(Duration.zero, () {
      var winner = ref.read(winnerCheckProvider);
      if (winner != '') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '${winner == 'C' ? 'تیم شهروند' : winner == 'M' ? 'تیم مافیا' : 'نقش مستقل'} پیروز این بازی شد ',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("بازی جدید"),
                  onPressed: () {
                    ref.invalidate(noteProvider);
                    ref.invalidate(selectedRolesProvider);
                    ref.invalidate(playersProvider);
                    ref.invalidate(selectedCitizenProvider);
                    ref.invalidate(selectedMafiaProvider);
                    ref.invalidate(selectedIndependentProvider);
                    ref.invalidate(mafiasProvider);
                    ref.invalidate(citizensProvider);
                    ref.invalidate(independentsProvider);
                    ref.invalidate(nightProvider);
                    ref.invalidate(dayProvider);
                    context.pop();
                    context.pop();
                  },
                ),
                TextButton(
                  child: const Text("ادامه بازی"),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Player> players = ref.watch(playersProvider);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: InGameAppBar(title: "روز ${persianNumber(dayN)}"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: players.length + 1,
                  itemBuilder: (BuildContext context, int index) =>
                      index < players.length
                          ? ListItemDay(players[index])
                          : const SizedBox(height: 75),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      height: 45,
                      child: FilledButton.tonalIcon(
                        icon: const Icon(Icons.timer),
                        label: Text(
                          " ${_current.toString()}",
                          style: const TextStyle(
                            fontSize: 29,
                          ),
                        ),
                        onPressed: startTimer,
                      ),
                    ),
                    MenuAnchor(
                      builder: (BuildContext context, MenuController controller,
                          Widget? child) {
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(Icons.keyboard_arrow_up),
                          tooltip: 'تغییر زمان تایمر',
                        );
                      },
                      menuChildren: List<MenuItemButton>.generate(
                        6,
                        (int index) => MenuItemButton(
                          onPressed: () {
                            if (_timer != null) _timer!.cancel();
                            setState(() =>
                                _current = _timerTime = _timerItems[index]);
                          },
                          child: Text('${_timerItems[index]}  ثانیه  '),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.navigate_before),
                      label: Text(dayN != 1 ? "رای گیری" : "شب"),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        if (_timer != null) _timer!.cancel();
                        ref.read(dayProvider.notifier).increment();
                        if (dayN == 1) {
                          context.pushReplacement(Routes.nightRoutePath);
                        } else {
                          ref.read(aliveProvider.notifier).countAlive();
                          context.pushReplacement(Routes.voteRoutePath);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() async {
    HapticFeedback.lightImpact();
    setState(() => _current = _timerTime);
    if (_timer != null) _timer!.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (time) async {
      setState(() => _current = _current - 1);
      if (_current == 0) {
        time.cancel();
        _current = _timerTime;
        await AudioPlayer().play(AssetSource('sounds/alarm.mp3'));
      }
    });
  }
}
