import 'package:code_running_front/common/base/mvp.dart';

/// 该类存储错误代码对应的提示
class CodeConstants {
  // 正常返回
  static int ok = 0;

  static final Map<int, String> m = {
    0: "正常返回",
    1001: "请先登录",
    1002: "手机号已注册",
    1003: "验证码错误",
    1004: "手机号未注册",
    1005: "密码错误",
    1006: "使者外出中",
    1007: "原密码与新密码相同",
    1008: "昵称不能以符号开头"
  };

  static String getMessage(ILoadingView view, int code) {
    if (code == 1001) {}
    return m[code] != null ? m[code] : "未知错误" + m[code].toString();
  }

  static String getNetworkErr() {
    return "网络错误";
  }
}
