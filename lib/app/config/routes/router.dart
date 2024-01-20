// import 'package:firebase_first_connect1/app/modules/navbar/view/bottom_navbar_scaffold';
import 'package:firbase_first_connect1/app/modules/navbar/view/bottom_navbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:firbase_first_connect1/app/config/routes/named_routes.dart';
import 'package:firbase_first_connect1/app/modules/auth/views/login.dart';
import 'package:firbase_first_connect1/app/modules/auth/views/register.dart';
import 'package:firbase_first_connect1/app/modules/auth/views/splashscreen.dart';
import 'package:firbase_first_connect1/app/modules/chats/domain/models/user_model.dart';
import 'package:firbase_first_connect1/app/modules/chats/view/chats_screen.dart';
import 'package:firbase_first_connect1/app/modules/navbar/widgets/bottom_navbar_tabs.dart';
import 'package:firbase_first_connect1/app/modules/one_to_one_chat/views/chat_room_page.dart';
import 'package:firbase_first_connect1/app/modules/profile/profile_screen.dart';

///[rootNavigatorKey] used for global | general navigation
final rootNavigatorKey = GlobalKey<NavigatorState>();

final shellRouteKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const SizedBox();

  /// use this in [MaterialApp.router]
  static final _router = GoRouter(
    initialLocation: MyNamedRoutes.root,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // outside the [ShellRoute] to make the screen on top of the [BottomNavBar]
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: MyNamedRoutes.root,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.login}",
        name: MyNamedRoutes.login,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.register}",
        name: MyNamedRoutes.register,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: RegisterScreen(),
        ),
      ),

      ShellRoute(
        navigatorKey: shellRouteKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(
            navtabs: BottomNavBarItem.navtabs(context),
            child: child,
          );
        },
        routes: [
          /// home route
          GoRoute(
            path: "/${MyNamedRoutes.chats}",
            name: MyNamedRoutes.chats,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: ChatsScreen(),
            ),
            routes: [
              GoRoute(
                path: "${MyNamedRoutes.chatDetails}",
                name: MyNamedRoutes.chatDetails,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: ChatRoomPage(
                    userModel: state.extra as UserModel,
                  ),
                ),
              ),
            ],
          ),

          /// profile route
          GoRoute(
            path: "/${MyNamedRoutes.profile}",
            name: MyNamedRoutes.profile,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
