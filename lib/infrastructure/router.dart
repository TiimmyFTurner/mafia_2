import 'package:go_router/go_router.dart';
import 'package:mafia_2/presentation/screens/home_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    )
  ],
);
