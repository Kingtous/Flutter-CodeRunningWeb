class HttpConstants {
  // 服务器
  static final serverAddress = "http://be.cishiapp.com/";

  ///******************************* action ****************************************/

  static final String bannerList = serverAddress + "bannerList";

  static final String smsCode = serverAddress + "users/smsSend";

  static final String userRegister = serverAddress + "users/register";

  static final String loginBySmsCode = serverAddress + "users/loginBySmsCode";

  static final String loginByPassword = serverAddress + "users/login";

  static final String editProfile = serverAddress + "users/alterInfo";

  // 用户登出
  static final String logOut = serverAddress + "users/logout";

  static final String loginByQQ = serverAddress + "users/qq";

  static final String loginByWechat = serverAddress + "users/wechat";

  static final String profile = serverAddress + "profile";

  static final String login = serverAddress + "users/login";

  // 第三方登录返回
  static final String thirdPartyCallBack =
      serverAddress + "users/loginCallback";

  // 修改密码
  static final String alterPassword = serverAddress + "users/alterPwd";

  static final String getAchievement =
      serverAddress + "achievement/getAchievement";

  // 获取星星币月亮币
  static final String getCoins = serverAddress + "users/getCoins";

  // 获取用户手机号
  static final String getPhoneNumberByToken =
      serverAddress + "users/getPhoneNumber";

  // 判断第三方登录是否绑定手机号
  static final String isBindPhone = serverAddress + "users/isBindPhone";

  // flag为1表示绑定，0表示未绑定
  static final int valueBound = 1;
  static final int valueUnbound = 0;

  // 修改字段值
  static final String alterField = serverAddress + "users/alterField";

  // 找回密码
  static final String findBackPwd = serverAddress + "users/findBackPwd";

  // 验证手机号/绑定新号码，如果为绑定新号码，则在QueryString下再加入oldPhone字段
  static final String checkPhoneOrBindNewPhone =
      serverAddress + "users/checkSmsCode";

  //月亮商城
  static final String showmoonmarket =
      serverAddress + "shop/shop_items/category/";
  static final String showgoodsstyles = serverAddress + "item/categories";
  static final String hadgoods = serverAddress + "item_owners/category/";
  static final String purchase = serverAddress + "shop/purchase";

  //抽奖
  static final String lottery = serverAddress + "gacha/draw";

  //使者
  static final String envoys_sum = serverAddress + "envoys/listAll";
  static final String envoys_detail = serverAddress + "envoys/getDetail";
  static final String recharge = serverAddress + "gacha/draw";

  //获取用户具体信息
  static final String listUserInfo = serverAddress + "users/listUserInfo";

  // 上传头像
  static final String uploadAvatar = serverAddress + "users/avatarUpload";

  // 是否绑定第三方账号
  static final String isBindThirdParty =
      serverAddress + "users/isBindThirdParty";

  // 解除绑定
  static final String unBindThirdParty =
      serverAddress + "users/unbindThirdParty";

  // 签到
  static final String signIn = serverAddress + "achievement/signIn";

  // 每日任务以及情况
  static final String dailyTask = serverAddress + "dailyQuest/getDailyQuest";

  // 每日任务以及情况
  static final String gainReward = serverAddress + "dailyQuest/gainReward";

  // 写想法
  static final String writeIdea = serverAddress + "idea/new";

  // [想法] 获取推荐的动态
  static final String getIdeas = serverAddress + "idea/recommend";

  // [想法] 评论动态
  static final String submitComment = serverAddress + "idea/comment/new";

  // [想法] 获取评论
  static final String getComments = serverAddress + "idea/comment/get";

  // [想法] 获取自己的5条动态
  static final String getSelfIdeas = serverAddress + "idea/self";
}
