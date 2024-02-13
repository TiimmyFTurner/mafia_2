import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mafia_2/infrastructure/router/routes_constant.dart';
import 'package:mafia_2/presentation/screens/day_screen.dart';
import 'package:mafia_2/presentation/screens/help_roles_screen.dart';
import 'package:mafia_2/presentation/screens/home_screen.dart';
import 'package:mafia_2/presentation/screens/how_to_play_screen.dart';
import 'package:mafia_2/presentation/screens/lock_screen.dart';
import 'package:mafia_2/presentation/screens/night_screen.dart';
import 'package:mafia_2/presentation/screens/set_players_screen.dart';
import 'package:mafia_2/presentation/screens/set_roles_screen.dart';
import 'package:mafia_2/presentation/screens/settings_screen.dart';
import 'package:mafia_2/presentation/screens/show_roles_screen.dart';
import 'package:mafia_2/presentation/screens/vote_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter _router = GoRouter(
    initialLocation: Routes.homeRoutePath,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.homeRoutePath,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.helpRolesRoutePath,
        builder: (context, state) => const HelpRolesScreen(),
      ),
      GoRoute(
        path: Routes.howToPlayRoutePath,
        builder: (context, state) => const HowToPlayScreen(),
      ),
      GoRoute(
        path: Routes.settingsRoutePath,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: Routes.setPlayersRoutePath,
        builder: (context, state) => const SetPlayersScreen(),
      ),
      GoRoute(
        path: Routes.setRolesRoutePath,
        builder: (context, state) => const SetRolesScreen(),
      ),
      GoRoute(
        path: Routes.showRolesRoutePath,
        builder: (context, state) => const ShowRolesScreen(),
      ),
      GoRoute(
        path: Routes.lockRoutePath,
        builder: (context, state) => const LockScreen(),
      ),
      GoRoute(
        path: Routes.dayRoutePath,
        builder: (context, state) => const DayScreen(),
      ),
      GoRoute(
        path: Routes.nightRoutePath,
        builder: (context, state) => const NightScreen(),
      ),
      GoRoute(
        path: Routes.voteRoutePath,
        builder: (context, state) => const VoteScreen(),
      )
    ],
  );

  static GoRouter get router => _router;
}
