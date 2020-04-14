import 'package:auto_route/auto_route.dart';
import 'package:code_running_front/router/my_router.gr.dart';

class NavUtil {
  static ExtendedNavigatorState<RouterBase> navigator() {
    return ExtendedNavigator.ofRouter<Router>();
  }
}
