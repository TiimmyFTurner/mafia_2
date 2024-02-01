import 'package:go_router/go_router.dart';
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

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'homeScreen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/helpRoles',
      name: 'helpRolesScreen',
      builder: (context, state) => const HelpRolesScreen(),
    ),
    GoRoute(
      path: '/howToPlay',
      name: 'howToPlay',
      builder: (context, state) => const HowToPlayScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/setPlayers',
      name: 'setPlayers',
      builder: (context, state) => const SetPlayersScreen(),
    ),
    GoRoute(
      path: '/setRoles',
      name: 'setRoles',
      builder: (context, state) => const SetRolesScreen(),
    ),
    GoRoute(
      path: '/showRoles',
      name: 'showRoles',
      builder: (context, state) => const ShowRolesScreen(),
    ),
    GoRoute(
      path: '/lock',
      name: 'lock',
      builder: (context, state) => const LockScreen(),
    ),
    GoRoute(
      path: '/day',
      name: 'day',
      builder: (context, state) => const DayScreen(),
    ),
    GoRoute(
      path: '/night',
      name: 'night',
      builder: (context, state) =>  const NightScreen(),
    )
  ],
);
