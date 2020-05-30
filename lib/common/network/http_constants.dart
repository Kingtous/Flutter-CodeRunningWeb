String get productionUrl => "https://code-api.kingtous.cn";

String get developmentUrl => "http://127.0.0.1:5000";

String get baseUrl => productionUrl;

String get loginApi => baseUrl + "/auth/login";

String get registerApi => baseUrl + "/auth/register";

String get uploadApi => baseUrl + "/file/upload";

String get runApi => baseUrl + "/code/run";

String get getCodeResultApi => baseUrl + "/code/getResult";

String get getSelfCodesApi => baseUrl + "/file/get_code/";

String get getMyThreadsApi => baseUrl + "/threads/me";

String get postThreadApi => baseUrl + "/threads/push_show";

// 管理员可用
String get deleteThreadApi => baseUrl + "/threads/delete";

String get getThreadsApi => baseUrl + "/threads/push_show";

String get signInApi => baseUrl + "/user/signIn";

String get getMyCreditsApi => baseUrl + "/user/myCredits";

String get postThreadCommentApi => baseUrl + "/threads/comment/submit";

String get deleteThreadCommentApi => baseUrl + "/threads/comment/del";

String get getThreadCommentsApi => baseUrl + "/threads/comment/get";

String get getUploadToken => baseUrl + "/file/getUploadToken";

String get likeProfileApi => baseUrl + "/user/profile/like/";

String get getUserProfileApi => baseUrl + "/user/profile/";

String get sendResetPasswordMailApi => baseUrl + "/auth/mail/reset_password";

String get resetPasswordApi => baseUrl + "/auth/profile/reset_password";

String get sendResetEmailApi => baseUrl + "/auth/sendRegisterMail";

String get getMallItemsApi => baseUrl + "/mall/get_items";

String get buyCartItemsApi => baseUrl + "/mall/cart/buy";

String get getCartItemsApi => baseUrl + "/mall/my_cart";

String get adminAddItems => baseUrl + "/mall/add_items";

String get getRepositoryItemsApi => baseUrl + "/repository/get";

String get addToCartApi => baseUrl + "/mall/cart/add";

// 管理员可用
String get delFromCartApi => baseUrl + "/mall/cart/del";

String get alterProfileApi => baseUrl + "/user/profile/alter";

// 以下是管理员API
String get changeUserRoleApi => baseUrl + "/user/change_role";

String get changeUserStatusApi => baseUrl + "/user/change_status";

String get getUserListApi => baseUrl + "/user/list";

String get changeItemStatusApi => baseUrl + "/mall/change_items";

String get addMallItemsApi => baseUrl + "/mall/add_items";


/// 错误原因 TODO 1013、1012
Map<int, String> errorMap = {
  1015: "无权限",
  1013: "操作太快，请稍后再试",
  1014: "您没有足够的积分",
  1012: "购物车物品不存在",
  1011: "服务器拒绝",
  1010: "已经点过赞了",
  1009: "评论不存在",
  1008: "已经签到过了",
  1007: "帖子不存在",
  1004: "用户名已存在",
  0: "正常返回",
  -1: "该用户名/邮箱已被注册，换个名字试试吧",
  1000: "用户登录信息过期",
  1001: "用户名不存在",
  1002: "输入内容格式错误，请检查格式问题",
  1003: "密码错误",
  1005: "请求的文件不存在",
  1006: "服务器故障，请稍后再试"
};

String getErrMsg(int code) {
  if (errorMap.containsKey(code)) {
    return errorMap[code];
  } else {
    return "未知错误";
  }
}

String getStateStr(int status) {
  switch (status) {
    case 0:
      return "正在排队，请稍后";
    case 1:
      return "正在编译";
    case 2:
      return "正在运行";
    case 3:
      return "已完成";
    case 4:
      return "错误";
    case 5:
      return "文件被服务器删除，请重试";
    case 6:
      return "运行出错";
    case 7:
      return "文件不受支持";
    case 8:
      return "编译失败";
  }
}
