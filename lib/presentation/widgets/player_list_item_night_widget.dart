import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';

class ListItemNight extends ConsumerStatefulWidget {
  final Player _player;

  const ListItemNight(this._player, {super.key});

  @override
  ListItemNightState createState() => ListItemNightState();
}

class ListItemNightState extends ConsumerState<ListItemNight> {
  @override
  Widget build(BuildContext context) {
    final player = widget._player;

    return InkWell(
      child: Card(
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
                      ? Colors.blue
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
                  Icons.volume_off,
                  color: Colors.white70,
                ),
                onPressed: () {
                  ref.read(playersProvider.notifier).silentPlayer(player.name);
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
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(

              title: const Text(
                "وظیفه",
              ),
              content: SingleChildScrollView(
                child: Text(player.role.job, textAlign: TextAlign.justify),
              ),
              actions: <Widget>[
                // TextButton(
                  //   onPressed: () {},
                  // => Navigator.of(context).push(
                  //             MaterialPageRoute(
                  //               builder: (_) => BigRoleName(player.role.name),
                  //             ),
                  //           ),
                //   child: const Text("نمایش تمام صفحه نقش"),
                // ),
                TextButton(
                  child: const Text("فهمیدم"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
