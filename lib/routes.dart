import 'package:go_router/go_router.dart';
import 'screens/ai_opponent.dart';
import 'screens/human_opponent.dart';
import 'screens/select_opponent.dart';


final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SelectOpponent(),
    ),
    GoRoute(
      path: '/playHuman',
      builder: (context, state) => const PlayHumanScreen(title: 'Play with another Player'),
    ),
    GoRoute(
      path: '/playAI',
      builder: (context, state) => const PlayAIScreen(title: 'Play with AI'),
    ),
  ],
);