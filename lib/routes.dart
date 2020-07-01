import 'package:flutter/widgets.dart';
import 'pages/pages.dart';

class AppRoutes {
  static const String homePage = '/home';
  static const String loginPage = '/login';
  static const String validationPage = '/login/validation';
}

class AppRouteKeys {
  static final Key homePage = const Key('__homePage__');
  static final Key userPage = const Key('__loginPage__');
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.homePage: (BuildContext context) => HomePage(),
  AppRoutes.loginPage: (BuildContext context) => LoginPage(),
  AppRoutes.validationPage: (BuildContext context) => ValidationPage(),
};
