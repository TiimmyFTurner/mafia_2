import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';
import 'package:mafia_2/presentation/helpers/lock_timer.dart';
import 'package:mafia_2/presentation/helpers/persian_number_helper.dart';
import 'package:mafia_2/presentation/widgets/in_game_app_bar_widget.dart';
import 'package:mafia_2/presentation/widgets/player_list_item_night_widget.dart';

class NightScreen extends ConsumerStatefulWidget {
  const NightScreen({super.key});

  @override
  NightScreenState createState() => NightScreenState();
}

AudioPlayer audioPlayer = AudioPlayer();

class NightScreenState extends ConsumerState<NightScreen> {
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
        appBar:
            InGameAppBar(title: "شب ${persianNumber(ref.read(nightProvider))}"),
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
                          ? ListItemNight(players[index])
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
                  child: FilledButton.tonalIcon(
                    icon: Icon(
                      audioPlayer.state != PlayerState.playing
                          ? Icons.play_arrow
                          : Icons.stop,
                    ),
                    label: const Text("موزیک"),
                    onPressed: () async {
                      if (audioPlayer.state != PlayerState.playing) {
                        await audioPlayer.play(AssetSource('sounds/night.mp3'));
                      } else {
                        await audioPlayer.stop();
                      }
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: FilledButton(
                    child: const Row(
                      children: [Text("  روز"), Icon(Icons.navigate_next)],
                    ),
                    onPressed: () async {
                      if (audioPlayer.state == PlayerState.playing) {
                        await audioPlayer.stop();
                      }
                      ref.read(nightProvider.notifier).increment();
                      if (context.mounted) context.pushReplacementNamed('day');
                    },
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
