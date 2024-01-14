// import 'package:firbase_first_connect1/app/config/routes/named_routes.dart';
// import 'package:firbase_first_connect1/app/modules/auth/views/login.dart';
// import 'package:firbase_first_connect1/app/modules/auth/views/register.dart';
// import 'package:firbase_first_connect1/app/modules/auth/views/splashscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// ///[rootNavigatorKey] used for global | general navigation
// final rootNavigatorKey = GlobalKey<NavigatorState>();

// abstract class AppRouter {
//   static Widget errorWidget(BuildContext context, GoRouterState state) =>
//       const SizedBox();

//   /// use this in [MaterialApp.router]
//   static final _router = GoRouter(
//     initialLocation: MyNamedRoutes.root,
//     navigatorKey: rootNavigatorKey,
//     debugLogDiagnostics: true,
//     routes: [
//       // outside the [ShellRoute] to make the screen on top of the [BottomNavBar]
//       GoRoute(
//         parentNavigatorKey: rootNavigatorKey,
//         path: MyNamedRoutes.root,
//         pageBuilder: (context, state) => NoTransitionPage(
//           key: state.pageKey,
//           child: const SplashScreen(),
//         ),
//       ),
//       GoRoute(
//         parentNavigatorKey: rootNavigatorKey,
//         path: "/${MyNamedRoutes.login}",
//         name: MyNamedRoutes.login,
//         pageBuilder: (context, state) => NoTransitionPage(
//           key: state.pageKey,
//           child: const LoginScreen(),
//         ),
//       ),
//       GoRoute(
//         parentNavigatorKey: rootNavigatorKey,
//         path: "/${MyNamedRoutes.register}",
//         name: MyNamedRoutes.register,
//         pageBuilder: (context, state) => NoTransitionPage(
//           key: state.pageKey,
//           child: RegisterScreen(),
//         ),
//       ),
//       GoRoute(
//         parentNavigatorKey: rootNavigatorKey,
//         path: "/${MyNamedRoutes.register}",
//         name: MyNamedRoutes.chats,
//         pageBuilder: (context, state) => NoTransitionPage(
//           key: state.pageKey,
//           child:ChatsrScreen(),
//         ),
//       ),

//       ShellRoute(
//   navigatorKey: shellNavigatorKey,
//   builder: (context, state, child) {
//     return ScaffoldWithBottomNavBar(
//       tabs: BottomNavBarTabs.tabs(context),
//       child: child,
//     );
//   },
//   routes: [
//     // Existing route for home screen
//     GoRoute(
//       path: "/${MyNamedRoutes.homePage}",
//       name: MyNamedRoutes.homePage,
//       pageBuilder: (context, state) => NoTransitionPage(
//         key: state.pageKey,
//         child: const HomePage(),
//       ),
//     ),
//     // Add new routes for Profile and Locations screens
//     GoRoute(
//       path: "/${MyNamedRoutes.profile}",
//       name: MyNamedRoutes.profile,
//       pageBuilder: (context, state) => NoTransitionPage(
//         key: state.pageKey,
//         child: const ProfileScreen(), // Replace with your Profile screen
//       ),
//     ),

//   ],
// ),

//     ]
//   );

//   static GoRouter get router => _router;
// }

import 'package:firbase_first_connect1/app/config/routes/named_routes.dart';
import 'package:firbase_first_connect1/app/modules/auth/views/login.dart';
import 'package:firbase_first_connect1/app/modules/auth/views/register.dart';
import 'package:firbase_first_connect1/app/modules/auth/views/splashscreen.dart';
import 'package:firbase_first_connect1/app/modules/chats/view/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[rootNavigatorKey] used for global | general navigation
final rootNavigatorKey = GlobalKey<NavigatorState>();

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

      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.chats}",
        name: MyNamedRoutes.chats,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ChatsScreen(),
        ),
      ),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
