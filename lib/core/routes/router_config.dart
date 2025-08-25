import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/routes/go_router_refresh_stream.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  //final appUserCubit = serviceLocator<AppUserCubit>();
  static GoRouter build(AppUserCubit appUserCubit) {
    
    return GoRouter(
      initialLocation: '/',
      refreshListenable: GoRouterRefreshStream(appUserCubit.stream),
      redirect: (context, state) {
        final isLoggedIn = appUserCubit.state is AppUserLoggedIn;

        final atGate = state.matchedLocation == '/';
        final atLogin = state.matchedLocation == '/sign_in_page';

        // While you're deciding, stay on /gate (prevents showing login)
        if (atGate) {
          // once isLoggedIn becomes true/false, redirect away
          return isLoggedIn ? '/home' : '/sign_in_page';
        }

        if (!isLoggedIn) return atLogin ? null : '/sign_in_page';
        if (atLogin) return '/home';
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
        ),
        GoRoute(
          path: '/sign_in_page',
          builder: (context, state) => const SignInPage(),
        ),
        GoRoute(
          path: '/sign_up_page',
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(path: '/home', builder: (context, state) => const Blogpage()),
        GoRoute(
          path: '/add_new_blog_page',
          builder: (context, state) => const AddNewBlogPage(),
        ),
        
        GoRoute(
          path: '/blog_viewer_page',
          builder: (context, state) =>  BlogViewerPage(blogData: state.extra as Blog),
        ),
      ],
    );
  }
}
