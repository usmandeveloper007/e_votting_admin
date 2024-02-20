import 'package:e_voting_admin/Features/Dashboard/View/dashboard_screen.dart';
import 'package:get/get.dart';

import '../Features/Authentication/View/login_screen.dart';

appRoutes() => [
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/dashboard',
    page: () => DashBoardScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: Duration(milliseconds: 500),
  ),
];
