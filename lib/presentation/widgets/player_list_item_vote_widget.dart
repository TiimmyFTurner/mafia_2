import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';

class ListItemVote extends ConsumerStatefulWidget {
  final Player _player;

  const ListItemVote(this._player, {super.key});

  @override
  ListItemVoteState createState() => ListItemVoteState();
}

class ListItemVoteState extends ConsumerState<ListItemVote> {
  @override
  Widget build(BuildContext context) {
    final player = widget._player;

    return Card(
      color: player.status == 'alive'
          ? Colors.green[800]
          : player.status == 'judge'
              ? Colors.yellow[800]
              : player.status == 'silent'
                  ? Colors.blueGrey
                  : Colors.red[800],
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.person,
                color: player.role.type == 'C'
                    ? Colors.blue
                    : player.role.type == 'M'
                        ? Colors.black
                        : Colors.deepOrangeAccent),
          ),
          Expanded(
            flex: 2,
            child: Text(
              player.name,
              style: const TextStyle(color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              player.role.name,
              style: const TextStyle(color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
              icon: const Icon(
                Icons.gavel,
                color: Colors.white70,
              ),
              onPressed: () {
                ref.read(playersProvider.notifier).judgePlayer(player.name);
              }),
          IconButton(
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.white70,
              ),
              onPressed: () {
                ref.read(playersProvider.notifier).killPlayer(player.name);
              }),
        ],
      ),
    );
  }
}
