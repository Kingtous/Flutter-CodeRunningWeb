import 'package:flutter/material.dart';

import '../business/user/dashboard/modules/profile/get/credits/bloc.dart';
import '../business/user/dashboard/modules/profile/get/profile/bloc.dart';
import '../business/user/models/response/resp_get_threads_entity.dart';

class Routes {
  static const String indexPage = '/';
  static const String loginPage = '/login-page';
  static const String userRegisterPage = '/user-register-page';
  static const String userDashBoard = '/user-dash-board';
  static const String codingPage = '/coding-page';
  static const String repositoryPage = '/repository-page';
  static const String threadGroundPage = '/thread-ground-page';
  static const String threadPage = '/thread-page';
  static const String storePage = '/store-page';
  static const String cartPage = '/cart-page';
  static const String homePage = '/home-page';
  static const String findBackPage = '/find-back-page';
  static const String itemsManagePage = '/items-manage-page';
  static const String threadsManagePage = '/threads-manage-page';
  static const String commentsManagePage = '/comments-manage-page';
  static const String usersPage = '/users-page';
  static const all = <String>{
    indexPage,
    loginPage,
    userRegisterPage,
    userDashBoard,
    codingPage,
    repositoryPage,
    threadGroundPage,
    threadPage,
    storePage,
    cartPage,
    homePage,
    findBackPage,
    itemsManagePage,
    threadsManagePage,
    commentsManagePage,
    usersPage,
  };
}

// class Router extends RouterBase {
//   @override
//   List<RouteDef> get routes => _routes;
//   final _routes = <RouteDef>[
//     RouteDef(Routes.indexPage, page: IndexPage),
//     RouteDef(Routes.loginPage, page: LoginPage),
//     RouteDef(Routes.userRegisterPage, page: UserRegisterPage),
//     RouteDef(Routes.userDashBoard, page: UserDashBoard),
//     RouteDef(Routes.codingPage, page: CodingPage),
//     RouteDef(Routes.repositoryPage, page: RepositoryPage),
//     RouteDef(Routes.threadGroundPage, page: ThreadGroundPage),
//     RouteDef(Routes.threadPage, page: ThreadPage),
//     RouteDef(Routes.storePage, page: StorePage),
//     RouteDef(Routes.cartPage, page: CartPage),
//     RouteDef(Routes.homePage, page: HomePage),
//     RouteDef(Routes.findBackPage, page: FindBackPage),
//     RouteDef(Routes.itemsManagePage, page: ItemsManagePage),
//     RouteDef(Routes.threadsManagePage, page: ThreadsManagePage),
//     RouteDef(Routes.commentsManagePage, page: CommentsManagePage),
//     RouteDef(Routes.usersPage, page: UsersPage),
//   ];
//   @override
//   Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
//   final _pagesMap = <Type, AutoRouteFactory>{
//     IndexPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => IndexPage(),
//         settings: data,
//       );
//     },
//     LoginPage: (data) {
//       final args = data.getArgs<LoginPageArguments>(nullOk: false);
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => LoginPage(
//           args.networkId,
//           args.timestamps,
//         ),
//         settings: data,
//       );
//     },
//     UserRegisterPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => UserRegisterPage(),
//         settings: data,
//       );
//     },
//     UserDashBoard: (data) {
//       final args = data.getArgs<UserDashBoardArguments>(
//         orElse: () => UserDashBoardArguments(),
//       );
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => UserDashBoard(key: args.key),
//         settings: data,
//       );
//     },
//     CodingPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => CodingPage(),
//         settings: data,
//       );
//     },
//     RepositoryPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => RepositoryPage(),
//         settings: data,
//       );
//     },
//     ThreadGroundPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => ThreadGroundPage(),
//         settings: data,
//       );
//     },
//     ThreadPage: (data) {
//       final args = data.getArgs<ThreadPageArguments>(
//         orElse: () => ThreadPageArguments(),
//       );
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => ThreadPage(
//           key: args.key,
//           data: args.data,
//         ),
//         settings: data,
//       );
//     },
//     StorePage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => StorePage(),
//         settings: data,
//       );
//     },
//     CartPage: (data) {
//       final args = data.getArgs<CartPageArguments>(
//         orElse: () => CartPageArguments(),
//       );
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => CartPage(
//           key: args.key,
//           getCreditsBloc: args.getCreditsBloc,
//         ),
//         settings: data,
//       );
//     },
//     HomePage: (data) {
//       final args = data.getArgs<HomePageArguments>(
//         orElse: () => HomePageArguments(),
//       );
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => HomePage(
//           key: args.key,
//           pBloc: args.pBloc,
//         ),
//         settings: data,
//       );
//     },
//     FindBackPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => FindBackPage(),
//         settings: data,
//       );
//     },
//     ItemsManagePage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => ItemsManagePage(),
//         settings: data,
//       );
//     },
//     ThreadsManagePage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => ThreadsManagePage(),
//         settings: data,
//       );
//     },
//     CommentsManagePage: (data) {
//       final args = data.getArgs<CommentsManagePageArguments>(
//         orElse: () => CommentsManagePageArguments(),
//       );
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => CommentsManagePage(
//           key: args.key,
//           threadId: args.threadId,
//         ),
//         settings: data,
//       );
//     },
//     UsersPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => UsersPage(),
//         settings: data,
//       );
//     },
//   };
// }

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LoginPage arguments holder class
class LoginPageArguments {
  final int networkId;
  final int timestamps;

  LoginPageArguments({@required this.networkId, @required this.timestamps});
}

/// UserDashBoard arguments holder class
class UserDashBoardArguments {
  final Key key;

  UserDashBoardArguments({this.key});
}

/// ThreadPage arguments holder class
class ThreadPageArguments {
  final Key key;
  final RespGetThreadsData data;

  ThreadPageArguments({this.key, this.data});
}

/// CartPage arguments holder class
class CartPageArguments {
  final Key key;
  final GetCreditsBloc getCreditsBloc;

  CartPageArguments({this.key, this.getCreditsBloc});
}

/// HomePage arguments holder class
class HomePageArguments {
  final Key key;
  final GetProfileBloc pBloc;

  HomePageArguments({this.key, this.pBloc});
}

/// CommentsManagePage arguments holder class
class CommentsManagePageArguments {
  final Key key;
  final int threadId;

  CommentsManagePageArguments({this.key, this.threadId});
}
