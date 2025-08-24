import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/routes/go_router_refresh_stream.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static GoRouter get goRouter {
    final appUserCubit = serviceLocator<AppUserCubit>();
    return GoRouter(
      refreshListenable: GoRouterRefreshStream(appUserCubit.stream),
      redirect: (context, state) {
        final isLoggedIn =
            context.read<AppUserCubit>().state is AppUserLoggedIn;
        final goingToLogin = state.matchedLocation == '/';

        if (!isLoggedIn) {
          if (!goingToLogin) return '/';
          return null;
        }
        // Logged in: keep them out of /login and /splash
        if (goingToLogin) return '/home';
        return null; // no redirect
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SignInPage()),
        GoRoute(
          path: '/sign_up_page',
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: Text('Home Page')),
            body: Column(children: [Text('Welcome to home page')]),
          ),
        ),
      ],
    );
  }
}
