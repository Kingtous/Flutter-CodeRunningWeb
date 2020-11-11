import 'package:code_running_front/application/application.dart';
import 'package:code_running_front/business/user/index/index_page.dart';
import 'package:code_running_front/business/user/login/login_page.dart';
import 'package:code_running_front/common/widgets/loading_dialog.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/third_libs_manager.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:get/get.dart';
import 'package:load/load.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'business/admin/ground_manage/comments_manage_page.dart';
import 'business/admin/ground_manage/threads_manage_page.dart';
import 'business/admin/mall_manage/mall_manage_page.dart';
import 'business/admin/user_manage/users_page.dart';
import 'business/user/dashboard/dashboard.dart';
import 'business/user/dashboard/modules/cart/cart_page.dart';
import 'business/user/dashboard/modules/code/coding_page.dart';
import 'business/user/dashboard/modules/code_repository/repository_page.dart';
import 'business/user/dashboard/modules/ground/comments/thread_page.dart';
import 'business/user/dashboard/modules/ground/ground_page.dart';
import 'business/user/dashboard/modules/home/home_page.dart';
import 'business/user/dashboard/modules/reset_password/find_back_page.dart';
import 'business/user/dashboard/modules/store/store_page.dart';
import 'business/user/register/register_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ThirdLibsManager.get().setup();
  SharedPreferences.getInstance().then((value) => {
        Application.sp = value,
        runApp(LoadingProvider(
            themeData: LoadingThemeData(),
            loadingWidgetBuilder: (ctx, data) {
              return LoadingDialog(
                text: "加载中",
              );
            },
            child: MyApp()))
      });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '码上社区-Coder Community',
      theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.blueAccent,
          primaryColor: Colors.black),
      getPages: [
        GetPage(name: Routes.indexPage, page: () => IndexPage()),
        GetPage(name: Routes.loginPage, page: () => LoginPage(0, 0)),
        GetPage(name: Routes.userRegisterPage, page: () => UserRegisterPage()),
        GetPage(name: Routes.userDashBoard, page: () => UserDashBoard()),
        GetPage(name: Routes.codingPage, page: () => CodingPage()),
        GetPage(name: Routes.repositoryPage, page: () => RepositoryPage()),
        GetPage(name: Routes.threadGroundPage, page: () => ThreadGroundPage()),
        GetPage(name: Routes.threadPage, page: () => ThreadPage()),
        GetPage(name: Routes.storePage, page: () => StorePage()),
        GetPage(name: Routes.cartPage, page: () => CartPage()),
        GetPage(name: Routes.homePage, page: () => HomePage()),
        GetPage(name: Routes.findBackPage, page: () => FindBackPage()),
        GetPage(name: Routes.itemsManagePage, page: () => ItemsManagePage()),
        GetPage(
            name: Routes.threadsManagePage, page: () => ThreadsManagePage()),
        GetPage(
            name: Routes.commentsManagePage, page: () => CommentsManagePage()),
        GetPage(name: Routes.usersPage, page: () => UsersPage()),
      ],
    );
  }
}
