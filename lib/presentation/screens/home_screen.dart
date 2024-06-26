// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/infrastructure/router/routes_constant.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("asset/theme/home_wp.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Hero(
                    tag: "play",
                    child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                                bottom: Radius.circular(4)),
                          ),
                        ),
                        child: const Text(
                          "شروع بازی جدید",
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          context.push(Routes.setPlayersRoutePath);
                        }),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: FilledButton.tonal(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          child: const Text(
                            "روش بازی",
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            context.push(Routes.howToPlayRoutePath);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: FilledButton.tonal(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          child: const Text(
                            "نقش ها",
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            ref
                                .read(customRoleProvider.notifier)
                                .recoverRoles();
                            context.push(Routes.helpRolesRoutePath);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(4),
                            bottom: Radius.circular(24)),
                      ),
                    ),
                    child: const Text(
                      "تنظیمات",
                      style: TextStyle(fontSize: 23),
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      context.push(Routes.settingsRoutePath);
                    },
                  ),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
