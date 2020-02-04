// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/router_utils.dart';
import 'package:code_running_front/business/main/view/index_page.dart';
import 'package:code_running_front/business/main/view/main_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static const indexRoute = '/';
  static const loginRoute = '/login-route';

  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();

  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.indexRoute:
        return MaterialPageRoute(
          builder: (_) => IndexPage(),
          settings: settings,
        );
      case Router.loginRoute:
        if (hasInvalidArgs<MainLoginPageArguments>(args)) {
          return misTypedArgsRoute<MainLoginPageArguments>(args);
        }
        final typedArgs =
            args as MainLoginPageArguments ?? MainLoginPageArguments();
        return MaterialPageRoute(
          builder: (_) =>
              MainLoginPage(typedArgs.networkId, typedArgs.timestamps),
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

//MainLoginPage arguments holder class
class MainLoginPageArguments {
  final int networkId;
  final int timestamps;

  MainLoginPageArguments({this.networkId, this.timestamps});
}
