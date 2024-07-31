import 'package:go_router/go_router.dart';
import 'package:spotify_clone_flutter/domain/entities/song/song_entity.dart';
import 'package:spotify_clone_flutter/presentation/auth/pages/sign_in_page.dart';
import 'package:spotify_clone_flutter/presentation/auth/pages/sign_up_or_sign_in_page.dart';
import 'package:spotify_clone_flutter/presentation/auth/pages/sign_up_page.dart';
import 'package:spotify_clone_flutter/presentation/choose_mode/pages/choose_mode_page.dart';
import 'package:spotify_clone_flutter/presentation/dashboard/pages/dashboard.dart';
import 'package:spotify_clone_flutter/presentation/home/pages/home_page.dart';
import 'package:spotify_clone_flutter/presentation/intro/pages/get_started_page.dart';
import 'package:spotify_clone_flutter/presentation/profile/profile_page.dart';
import 'package:spotify_clone_flutter/presentation/song_player/pages/song_player_page.dart';
import 'package:spotify_clone_flutter/presentation/splash/pages/splash_page.dart';

enum AppRoute {
  splash,
  onboarding,
  chooseMode,
  registerOrSignIn,
  register,
  signIn,
  dashboard,
  home,
  profile,
  player,
}

class AppRouterConfig {
  late final GoRouter router = GoRouter(
    routes: _routes,
    initialLocation: '/',
  );

  void dispose() {}

  late final _routes = <RouteBase>[
    GoRoute(
      path: '/',
      name: AppRoute.splash.name,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: AppRoute.onboarding.name,
      builder: (context, state) => const GetStartedPage(),
    ),
    GoRoute(
      path: '/chooseMode',
      name: AppRoute.chooseMode.name,
      builder: (context, state) => const ChooseModePage(),
    ),
    GoRoute(
      path: '/registerOrSignIn',
      name: AppRoute.registerOrSignIn.name,
      builder: (context, state) => const SignupOrSigninPage(),
    ),
    GoRoute(
      path: '/register',
      name: AppRoute.register.name,
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: '/signIn',
      name: AppRoute.signIn.name,
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: '/dashboard',
      name: AppRoute.dashboard.name,
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/home',
      name: AppRoute.home.name,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/profile',
      name: AppRoute.profile.name,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/songPlayer',
      name: AppRoute.player.name,
      builder: (context, state) {
        final songEntity = state.extra as SongEntity;
        return SongPlayerPage(
          songEntity: songEntity,
        );
      },
    ),
    //  GoRoute(
    //   path: '/onboarding',
    //   name: AppRoute.onboarding.name,
    //   builder: (_, __) => BlocProvider(
    //     create: (_) => HomeBloc(inject()),
    //     child: MainScreen(
    //       viewModel: MainScreenViewModel(),
    //     ),
    //   ),
    // ),
  ];
}
