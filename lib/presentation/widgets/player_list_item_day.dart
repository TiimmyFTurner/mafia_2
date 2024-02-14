// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';

class ListItemDay extends ConsumerStatefulWidget {
  final Player _player;

  const ListItemDay(this._player, {super.key});

  @override
  ListItemDayState createState() => ListItemDayState();
}

class ListItemDayState extends ConsumerState<ListItemDay> {
  @override
  Widget build(BuildContext context) {
    final player = widget._player;
    return Card(
      color: player.status == 'alive'
          ? Colors.green[800]
          : player.status == 'silent'
              ? Colors.blueGrey
              : Colors.red[800],
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.person,
                color: player.role.type == 'C'
                    ? Colors.lightBlueAccent
                    : player.role.type == 'M'
                        ? Colors.black
                        : Colors.orange),
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
                Icons.power_settings_new,
                color: Colors.white70,
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                ref.read(playersProvider.notifier).killPlayer(player.name);
              }),
        ],
      ),
    );
  }
}
