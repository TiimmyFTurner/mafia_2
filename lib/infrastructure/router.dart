import 'package:go_router/go_router.dart';
import 'package:mafia_2/presentation/screens/help_roles_screen.dart';
import 'package:mafia_2/presentation/screens/home_screen.dart';

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
      builder: (context, state) =>  HelpRolesScreen(),
    )
  ],
);
