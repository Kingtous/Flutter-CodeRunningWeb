// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:code_running_front/business/user/index/index_page.dart';
import 'package:code_running_front/business/user/login/login_page.dart';
import 'package:code_running_front/business/user/register/register_page.dart';
import 'package:code_running_front/business/user/dashboard/dashboard.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/coding_page.dart';

abstract class Routes {
  static const indexRoute = '/';
  static const loginRoute = '/login-route';
  static const userRegisterPage = '/user-register-page';
  static const userDashBoard = '/user-dash-board';
  static const codePage = '/code-page';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.indexRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => IndexPage(),
          settings: settings,
        );
      case Routes.loginRoute:
        if (hasInvalidArgs<LoginPageArguments>(args)) {
          return misTypedArgsRoute<LoginPageArguments>(args);
        }
        final typedArgs = args as LoginPageArguments ?? LoginPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => LoginPage(typedArgs.networkId, typedArgs.timestamps),
          settings: settings,
        );
      case Routes.userRegisterPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => UserRegisterPage(),
          settings: settings,
        );
      case Routes.userDashBoard:
        return MaterialPageRoute<dynamic>(
          builder: (_) => UserDashBoard(),
          settings: settings,
        );
      case Routes.codePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => CodingPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//LoginPage arguments holder class
class LoginPageArguments {
  final int networkId;
  final int timestamps;
  LoginPageArguments({this.networkId, this.timestamps});
}
