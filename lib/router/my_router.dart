import 'package:auto_route/auto_route_annotations.dart';
import 'package:code_running_front/business/user/dashboard/dashboard.dart';
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

}
