import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mafia_2/applications/state_management/last_moves_provider.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/last_move_model.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';
import 'package:mafia_2/infrastructure/router/routes_constant.dart';
import 'package:mafia_2/presentation/helpers/lock_timer.dart';
import 'package:mafia_2/presentation/widgets/in_game_app_bar_widget.dart';
import 'package:mafia_2/presentation/widgets/player_list_item_vote_widget.dart';

class VoteScreen extends ConsumerStatefulWidget {
  const VoteScreen({super.key});

  @override
  VoteScreenState createState() => VoteScreenState();
}

class VoteScreenState extends ConsumerState<VoteScreen> {
  @override
  void initState() {
    lockTimer(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Player> players = ref.watch(playersProvider);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const InGameAppBar(title: "رای دهی"),
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
                          ? ListItemVote(players[index])
                          : const SizedBox(height: 75),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 35,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.heartPulse,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                Text(
                                  " ${ref.watch(aliveProvider)}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.orange,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.gavel,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                Text(
                                  " ${ref.watch(voteToJudgeProvider)}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.red[700],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.skullCrossbones,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                Text(
                                  " ${ref.watch(voteToDeadProvider)}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: FilledButton.tonal(
                    child: const Row(
                      children: [Text("حرکت آخر")],
                    ),
                    onPressed: () {
                      LastMove card =
                          ref.read(lastMovesProvider.notifier).pickCard();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: card.color == "R"
                                ? Colors.redAccent
                                : card.color == "B"
                                    ? Colors.brown
                                    : card.color == "D"
                                        ? Colors.black
                                        : Colors.blueGrey,
                            title: Text(card.name,
                                style: const TextStyle(color: Colors.white)),
                            content: Text(card.description,
                                style: const TextStyle(color: Colors.white)),
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: const Text("بازگشت"),
                                onPressed: () => context.pop(),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.navigate_before),
                      label: const Text("شب"),
                      onPressed: () {
                        context.pushReplacement(Routes.nightRoutePath);
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
}
