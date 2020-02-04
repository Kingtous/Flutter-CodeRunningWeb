import 'package:auto_route/auto_route_annotations.dart';
import 'package:code_running_front/business/main/view/index_page.dart';
import 'package:code_running_front/business/main/view/main_login_page.dart';

@autoRouter
class $Router {
  @initial
  IndexPage indexRoute;

  MainLoginPage loginRoute;
}
