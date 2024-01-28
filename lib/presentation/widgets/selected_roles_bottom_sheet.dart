import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/presentation/widgets/role_list_item_widget.dart';

const double minHeight = 90;

class SelectedRolesBottomSheet extends ConsumerStatefulWidget {
  const SelectedRolesBottomSheet({super.key});

  @override
  SelectedRolesBottomSheetState createState() =>
      SelectedRolesBottomSheetState();
}

class SelectedRolesBottomSheetState
    extends ConsumerState<SelectedRolesBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double get maxHeight => MediaQuery.of(context).size.height / 1.15;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double? lerp(double min, double max) =>
      lerpDouble(min, max, _animationController.value);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          bottom: 0,
          right: 0,
          left: 0,
          child: GestureDetector(
            onTap: _toggle,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.4),
                      blurRadius: 10,
                      offset: const Offset(-3, -.5))
                ],
                color: Theme.of(context).colorScheme.inversePrimary,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  RotationTransition(
                                      turns:
                                          AlwaysStoppedAnimation(lerp(0, .5)!),
                                      child:
                                          const Icon(Icons.keyboard_arrow_up)),
                                  Expanded(
                                    child: Text(
                                      'نقش های انتخاب شده',
                                      style: TextStyle(fontSize: lerp(17, 20)),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 10, left: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                color: Colors.red,
                                                size: 18,
                                              ),
                                              Text(
                                                " ${ref.watch(selectedMafiaProvider)}",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                color: Colors.green,
                                                size: 18,
                                              ),
                                              Text(
                                                " ${ref.watch(selectedCitizenProvider) - ref.watch(selectedIndependentProvider)}",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 10, left: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                color: Colors.orange,
                                                size: 18,
                                              ),
                                              Text(
                                                " ${ref.watch(selectedIndependentProvider)}",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            child: const Row(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("پخش نقش"),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                            onPressed: () {
                              if (ref.read(selectedRolesProvider).isNotEmpty) {
                                ref.read(selectedRolesProvider.notifier).saveRoles();
                                // ref.read(playersProvider.notifier).setPlayers();
                              }
                              // if (!Provider.of<RolesNPlayers>(context,
                              //         listen: false)
                              //     .selectedRoles
                              //     .isEmpty) {
                              //   Provider.of<RolesNPlayers>(context,
                              //           listen: false)
                              //       .saveRoles();
                              //   Provider.of<RolesNPlayers>(context,
                              //           listen: false)
                              //       .setPlayers();
                              //   Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (_) => ShowRoles()),
                              //   );
                              // }
                            },
                          ),
                        ),
                      ],
                    ),
                    _buildSelectedItemList(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggle() {
    setState(() {});
    final bool isOpen =
        _animationController.status == AnimationStatus.completed;
    _animationController.fling(velocity: isOpen ? -2 : 2);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _animationController.value -= details.primaryDelta! / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0) {
      _animationController.fling(velocity: max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _animationController.fling(velocity: min(-2.0, -flingVelocity));
    } else {
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
    }
  }

  Widget _buildSelectedItemList() {
    dynamic roles = ref.watch(selectedRolesProvider);
    return roles.length != 0
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: (2.5 / 1),
                children: List.generate(
                  roles.length,
                  (index) => InkWell(
                    borderRadius: BorderRadius.circular(20),
                    radius: 200,
                    child: RoleListItemWidget(roles[index]),
                    onTap: () {
                      ref
                          .read(selectedRolesProvider.notifier)
                          .removeRole(roles[index]);
                    },
                    onLongPress: () => showRoleJob(context, roles[index]),
                  ),
                ),
              ),
            ),
          )
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: lerp(0, 1)! > .8
                ? Column(
                    children: [
                      Image.asset("asset/theme/empty.png"),
                      const Text(
                        'نقشی انتخاب نشده',
                        style: TextStyle(fontSize: 22),
                      ),
                      const Opacity(
                        opacity: .6,
                        child: Text(
                          "برای شروع بازی نقش های دلخواه خود را انتخاب کنید ",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  )
                : Container(),
          );
  }

  showRoleJob(_, role) {
    return showDialog(
      context: _,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            role.name,
          ),
          content: SingleChildScrollView(
            child: Text(
              role.job,
            ),
          ),
          actions: <Widget>[
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
  }
}
