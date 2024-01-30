import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/player_model.dart';
import 'package:mafia_2/presentation/widgets/role_dialog_widget.dart';
import 'package:action_slider/action_slider.dart';

class ShowRolesScreen extends ConsumerStatefulWidget {
  const ShowRolesScreen({super.key});

  @override
  ShowRolesScreenState createState() => ShowRolesScreenState();
}

class ShowRolesScreenState extends ConsumerState<ShowRolesScreen> {
  bool _lock = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      setState(() {
        _lock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Player> players = [...ref.read(playersProvider)];
    return PopScope(
      canPop: false,
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
                              padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          enableDrag: true,
                          isScrollControlled: true,
                          builder: (builder) => RoleDialog(
                            title: players[index].name,
                            desc: "نقش: " +
                                players[index].role.name +
                                "\nگروه: " +
                                role,
                            btn: "فهمیدم",
                            more: players[index].role.job,

                            image: AssetImage(
                              "asset/images/" + players[index].role.type + ".jpg",
                            ),
                          ),
                        ).then(
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
