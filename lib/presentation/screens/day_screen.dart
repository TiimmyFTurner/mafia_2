import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mafia_2/applications/state_management/note_provider.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';
import 'package:mafia_2/presentation/helpers/lock_timer.dart';
import 'package:mafia_2/presentation/helpers/persian_number_helper.dart';
import 'package:mafia_2/presentation/widgets/in_game_app_bar_widget.dart';
import 'package:mafia_2/presentation/widgets/player_list_item_day.dart';

class DayScreen extends ConsumerStatefulWidget {
  const DayScreen({super.key});

  @override
  DayScreenState createState() => DayScreenState();
}

Timer? _timer;
int _current = 30;

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
                    Navigator.of(context).pop();
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
                SizedBox(
                  height: 45,
                  child: FilledButton.tonal(
                    onPressed: startTimer,
                    child: Row(
                      children: [
                        const Icon(Icons.timer),
                        Text(
                          " ${_current.toString()}",
                          style: const TextStyle(
                            fontSize: 29,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: FilledButton(
                    child: Row(
                      children: [
                        Text(dayN != 1 ? "رای گیری" : "شب"),
                        const Icon(Icons.navigate_next)
                      ],
                    ),
                    onPressed: () {
                      ref.read(dayProvider.notifier).increment();
                      if (dayN == 1) {
                        context.pushReplacementNamed("night");
                      }
                      //TODO implement when vote screen is done
                      // else
                      //   Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(builder: (_) => Vote()),
                      //   );
                      // Provider.of<RolesNPlayers>(context, listen: false)
                      //     .startVoting();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _current = 31;
    if (_timer != null) _timer!.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (time) {
      setState(() {
        _current = _current - 1;
        if (_current < 1) time.cancel();
      });
    });
  }
}
