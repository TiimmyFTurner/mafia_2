import 'package:go_router/go_router.dart';
import 'package:mafia_2/presentation/screens/help_roles_screen.dart';
import 'package:mafia_2/presentation/screens/home_screen.dart';
import 'package:mafia_2/presentation/screens/how_to_play_screen.dart';
import 'package:mafia_2/presentation/screens/set_players_screen.dart';
import 'package:mafia_2/presentation/screens/settings_screen.dart';

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
      builder: (context, state) =>  const HelpRolesScreen(),
    ),
    GoRoute(
      path: '/howToPlay',
      name: 'howToPlay',
      builder: (context, state) =>  const HowToPlayScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) =>  const SettingsScreen(),
    ),
    GoRoute(
      path: '/setPlayers',
      name: 'setPlayers',
      builder: (context, state) =>  const SetPlayersScreen(),
    ),
  ],
);
