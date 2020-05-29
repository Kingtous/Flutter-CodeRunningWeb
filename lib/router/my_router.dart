import 'package:auto_route/auto_route_annotations.dart';
import 'package:code_running_front/business/admin/mall_manage/mall_manage_page.dart';
import 'package:code_running_front/business/admin/user_manage/users_page.dart';
import 'package:code_running_front/business/user/dashboard/dashboard.dart';
import 'package:code_running_front/business/user/dashboard/modules/cart/cart_page.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/coding_page.dart';
import 'package:code_running_front/business/user/dashboard/modules/code_repository/repository_page.dart';
import 'package:code_running_front/business/user/dashboard/modules/ground/comments/thread_page.dart';
import 'package:code_running_front/business/user/dashboard/modules/ground/ground_page.dart';
import 'package:code_running_front/business/user/dashboard/modules/home/home_page.dart';
import 'package:code_running_front/business/user/dashboard/modules/reset_password/find_back_page.dart';
import 'package:code_running_front/business/user/dashboard/modules/store/store_page.dart';
import 'package:code_running_front/business/user/index/index_page.dart';
import 'package:code_running_front/business/user/login/login_page.dart';
import 'package:code_running_front/business/user/register/register_page.dart';


@MaterialAutoRouter()
class $Router {
  @initial
  IndexPage indexRoute;
  LoginPage loginRoute;
  UserRegisterPage userRegisterPage;
  UserDashBoard userDashBoard;
  CodingPage codePage;
  RepositoryPage userRepositoryPage;
  ThreadGroundPage threadGroundPage;
  ThreadPage threadDetailPage;
  StorePage mallPage;
  CartPage cartPage;
  HomePage homePage;
  FindBackPage findBackPasswordPage;
  UsersPage usersPage;
  ItemsManagePage itemsManagePage;
}
