import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';
import 'package:action_slider/action_slider.dart';

class ShowRolesScreen extends ConsumerStatefulWidget {
  const ShowRolesScreen({super.key});

  @override
  ShowRolesScreenState createState() => ShowRolesScreenState();
}

class ShowRolesScreenState extends ConsumerState<ShowRolesScreen> {
  bool _lock = false;
  late List<Player> players;

  @override
  void initState() {
    players = [...ref.read(playersProvider)];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      setState(() {
        _lock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      //TODO Set to false when u done implementing
      // canPop: false,
      child: Scaffold(
        appBar: AppBar(title: const Text("نمایش نقش ها")),
        body: players.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ActionSlider.standard(
                    sliderBehavior: SliderBehavior.stretch,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    action: (controller) {
                      controller.success();
                      //TODO: IMPLEMENT THIS
                      // Provider.of<LastMoveProvider>(context, listen: false)
                      //     .newGame();
                      // Provider.of<RolesNPlayers>(context, listen: false)
                      //     .playGame();
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(builder: (_) => Day()),
                      // );
                    },
                    child: const Text("برای شروع بازی بکشید"),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: (2 / 1),
                  children: List.generate(players.length, (index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: _lock ? 1 : 0,
                        curve: Curves.easeInOutQuart,
                        child: AnimatedPadding(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.ease,
                          padding: _lock
                              ? EdgeInsets.zero
                              : EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 6,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        players[index].name,
                                        maxLines: 3,
                                        style: const TextStyle(height: 1.2),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.person, color: Colors.blue),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        String role = players[index].role.type == 'C'
                            ? "شهروند"
                            : players[index].role.type == 'M'
                                ? "مافیا"
                                : "مستقل";
                        showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            builder: (builder) => Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              players[index].name,
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              "نقش: ${players[index].role.name}\nگروه: $role",
                                              style: const TextStyle(
                                                  fontSize: 27.0),
                                              textAlign: TextAlign.center,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surfaceVariant,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                    players[index].role.job,
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                      child: SizedBox(
                                        // width: double.infinity,
                                        height: 55,
                                        child: FilledButton.tonal(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("فهمیدم"),
                                        ),
                                      ),
                                    ),
                                  ],
                                )).then(
                          (value) => setState(() {
                            players.remove(players[index]);
                          }),
                        );
                      },
                    );
                  }),
                ),
              ),
      ),
    );
  }
}
