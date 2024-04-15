import 'package:go_router/go_router.dart';
import 'package:gps_tracking/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    // home
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen()
    ),

    // GoRoute(
    //   path: '/alert',
    //   builder: (context, state) => const AlertScreen()
    // ),
  ]
);