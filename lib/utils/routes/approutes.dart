
import '../../view/homescreen.dart';
import '../../view/loginscreen.dart';
import '../../view/signupscreen.dart';
import '../../view/splashscreen.dart';
import 'package:go_router/go_router.dart';


final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: '/homeScreen',
      path: '/homeScreen',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      name: '/loginScreen',
      path: '/loginScreen',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: '/signUpScreen',
      path: '/signUpScreen',
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      name: '/splashScreen',
      path: '/',
      builder: (context, state) => SplashPage(),
    ),
  ],
);
