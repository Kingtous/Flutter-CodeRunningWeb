import 'package:code_running_front/application/application.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/ui/nav_util.dart';

void popToUserIndex() {
  NavUtil.navigator()
      .pushNamedAndRemoveUntil(Routes.indexRoute, (route) => false);
}

String getStoredToken() {
  try {
    String token = Application.sp.get("token");
    if (token == null) {
      // 退出
      return "";
    } else {
      return token;
    }
  } finally {
    popToUserIndex();
  }
}
