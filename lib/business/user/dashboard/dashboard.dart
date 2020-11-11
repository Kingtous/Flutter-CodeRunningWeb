import 'dart:async';

import 'package:code_running_front/business/user/dashboard/modules/profile/get/credits/bloc.dart';
import 'package:code_running_front/business/user/models/request/req_get_credits_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_profile_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/common/utils/toast_utils.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/utils/enum.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'modules/profile/get/credits/get_credits_bloc.dart';
import 'modules/profile/get/profile/bloc.dart';

class UserDashBoard extends StatefulWidget {
  UserDashBoard({Key key}) : super(key: key);

  @override
  UserDashBoardState createState() => UserDashBoardState();
}

class UserDashBoardState extends BaseLoadingPageState<UserDashBoard> {
  GetProfileBloc _getProfileBloc;
  GetCreditsBloc _getCreditsBloc;

  GetProfileBloc get getProfileBloc => _getProfileBloc;

  @override
  void initState() {
    super.initState();
    _getProfileBloc = GetProfileBloc();
    _getCreditsBloc = GetCreditsBloc();
    _getProfileBloc
        ?.add(InGetProfileEvent(ReqGetProfileEntity()..id = getUserInfo().id));
    _getCreditsBloc.add(InGetCreditsEvent(ReqGetCreditsEntity()));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ToastUtils.show("正在加载中，请稍后");
    });
  }

  @override
  void dispose() {
    debugPrint("dispose dashboard");
    _getProfileBloc?.close();
    _getCreditsBloc?.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("主界面"),
        actions: <Widget>[
          Container(
              alignment: Alignment.center,
              child: Text("你好 " + getUserInfo().username)),
          FlatButton.icon(
              onPressed: handleExit,
              icon: FaIcon(FontAwesomeIcons.doorOpen),
              label: Text(
                "退出登录",
                style: TextStyles.textWhite14,
              ))
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              ImageLoadView(
                "images/background/02.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size
                    .height,
                placeholder: "images/placeholders/black.jpg",
                imageType: ImageType.assets,
              ),
              buildContent()
            ],
          )),
    );
  }

  void handleExit() {
    showSuccess(msg: "您已退出");
    Timer(Duration(seconds: 2), () => logOut());
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  /// 菜单，左侧为功能菜单，右侧为动态
  Widget buildContent() =>
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildMoments(),
              kIsWeb
                  ? SizedBox(
                      height: 50,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              buildMenu()
            ],
          ),
        ),
      );

  Widget buildMenu() =>
      BlocBuilder(
        bloc: _getProfileBloc,
        builder: (BuildContext context, state) {
          if (state is GetProfileedState) {
            return state.entity.data.role == 0
                ? buildUserMenu()
                : buildAdminMenu();
          } else {
            return SizedBox();
          }
        },
      );

  Widget buildUserMenu() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          GestureDetector(
              onTap: () => {handleEditorOpen(context)},
              child: buildMenuBtn(
                  FaIcon(
                    FontAwesomeIcons.code,
                    size: 25,
                    color: Colors.white,
                  ),
                  "我的编辑器",
                  "开始创作")),
          GestureDetector(
            onTap: () {
              handleRepositoryOpen(context);
            },
            child: buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.cloud,
                  size: 25,
                  color: Colors.white,
                ),
                "我的码库",
                "代码历史"),
          ),
          GestureDetector(
            onTap: () => {handleGroundOpen(context)},
            child: buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.warehouse,
                  size: 25,
                  color: Colors.white,
                ),
                "论坛广场",
                "发现你的所见所闻"),
          ),
          GestureDetector(
            onTap: () => {handleMallOpen(context)},
            child: buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.shoppingCart,
                  size: 25,
                  color: Colors.white,
                ),
                "社区点点通",
                "知识带回家"),
          ),
          GestureDetector(
            onTap: () => {handleCartOpen(context)},
            child: buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.shoppingCart,
                  size: 25,
                  color: Colors.white,
                ),
                "我的购物车",
                "我的知识宝库"),
          ),
          GestureDetector(
            onTap: () => {handleHomeOpen(context)},
            child: buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.cogs,
                  size: 25,
                  color: Colors.white,
                ),
                "个人主页",
                "购买的项目、资料设置"),
          )
        ],
      ),
    );
  }

  Widget buildAdminMenu() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          GestureDetector(
              onTap: () => {handleUserListOpen(context)},
              child: buildMenuBtn(
                  FaIcon(
                    FontAwesomeIcons.user,
                    size: 25,
                    color: Colors.white,
                  ),
                  "用户管理",
                  "职责、账户管理")),
          GestureDetector(
            onTap: () => {handleGroundManageOpen(context)},
            child: buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.cloud,
                  size: 25,
                  color: Colors.white,
                ),
                "广场管理",
                "帖子、评论"),
          ),
          GestureDetector(
            onTap: () => {handleMallManageOpen(context)},
            child: buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.warehouse,
                  size: 25,
                  color: Colors.white,
                ),
                "点点通管理",
                "上架、下架商品"),
          ),
          GestureDetector(
            onTap: () => {handleHomeOpen(context)},
            child: buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.cogs,
                  size: 25,
                  color: Colors.white,
                ),
                "个人主页",
                "购买的项目、资料设置"),
          )
        ],
      ),
    );
  }

  /// 动态
  Widget buildMoments() {
    var info = getUserInfo();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        //时间面板
        // FlutterAnalogClock(
        //   dateTime: DateTime.now(),
        //   dialPlateColor: Colors.white,
        //   hourHandColor: Colors.black,
        //   minuteHandColor: Colors.black,
        //   secondHandColor: Colors.black,
        //   numberColor: Colors.black,
        //   borderColor: Colors.black,
        //   tickColor: Colors.black,
        //   centerPointColor: Colors.black,
        //   showBorder: true,
        //   showTicks: true,
        //   showMinuteHand: true,
        //   showSecondHand: true,
        //   showNumber: true,
        //   borderWidth: 8.0,
        //   hourNumberScale: .10,
        //   hourNumbers: [
        //     'I',
        //     'II',
        //     'III',
        //     'IV',
        //     'V',
        //     'VI',
        //     'VII',
        //     'VIII',
        //     'IX',
        //     'X',
        //     'XI',
        //     'XII'
        //   ],
        //   isLive: true,
        //   width: 100,
        //   height: 100,
        // ),
        // Gaps.vGap(16.0),
        Card(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BlocBuilder(
                  bloc: _getProfileBloc,
                  builder: (BuildContext context, state) {
                    if (state is GetProfileedState) {
                      return Container(
                        alignment: Alignment.center,
                        child: ImageLoadView(
                          state.entity.data.avatarUrl,
                          height: 75,
                          width: 75,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: 0,
                      );
                    }
                  },
                ),
                Gaps.vGap(8.0),
                BlocBuilder(
                  bloc: _getProfileBloc,
                  builder: (BuildContext context, state) {
                    if (state is GetProfileedState) {
                      return Text(
                        "ID:${state.entity.data.username}",
                        style: TextStyles.textDark14,
                        textAlign: TextAlign.start,
                      );
                    } else {
                      return SizedBox(
                        width: 0,
                      );
                    }
                  },
                ),
                Gaps.vGap(8.0),
                BlocBuilder(
                  bloc: _getProfileBloc,
                  builder: (BuildContext context, state) {
                    if (state is GetProfileedState) {
                      return Text("昵称:${state.entity.data.nickname}",
                          style: TextStyles.textDark14,
                          textAlign: TextAlign.start);
                    } else {
                      return SizedBox(
                        width: 0,
                      );
                    }
                  },
                ),
                Gaps.vGap(8.0),
                BlocBuilder(
                  bloc: _getCreditsBloc,
                  builder: (BuildContext context, state) {
                    if (state is GetCreditsedState) {
                      return Text("积分:${state.entity.data.credits}",
                          style: TextStyles.textDark14,
                          textAlign: TextAlign.start);
                    } else {
                      return SizedBox(
                        width: 0,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildMenuBtn(Widget img, String text, String subtext,
      {Function() onclick}) =>
      Card(
        elevation: 10,
        shape: RoundedRectangleBorder(),
        color: Color(0x50000000),
        child: Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 25,
                alignment: Alignment.center,
                child: img,
              ),
              Gaps.vGap(8),
              Text(
                text,
                style: TextStyles.textWhite16,
                textAlign: TextAlign.center,
              ),
              Gaps.vGap(8),
              Text(subtext,
                  style: TextStyles.textWhite14, textAlign: TextAlign.center)
            ],
          ),
        ),
      );

  void handleEditorOpen(context) {
    Get.toNamed(Routes.codingPage);
  }

  handleRepositoryOpen(BuildContext context) {
    Get.toNamed(Routes.repositoryPage);
  }

  handleGroundOpen(BuildContext context) {
    Get.toNamed(Routes.threadGroundPage).then((value) =>
        _getCreditsBloc.add(InGetCreditsEvent(ReqGetCreditsEntity())));
  }

  handleMallOpen(BuildContext context) {
    Get.toNamed(Routes.storePage);
  }

  handleCartOpen(BuildContext context) {
    Get
        .toNamed(Routes.cartPage,
        arguments: CartPageArguments(getCreditsBloc: _getCreditsBloc))
        .then((value) =>
        _getCreditsBloc.add(InGetCreditsEvent(ReqGetCreditsEntity())));
  }

  handleHomeOpen(BuildContext context) {
    Get
        .toNamed(Routes.homePage,
        arguments: HomePageArguments(pBloc: _getProfileBloc))
        .then((value) =>
        _getProfileBloc?.add(
            InGetProfileEvent(ReqGetProfileEntity()
              ..id = getUserInfo().id)));
  }

  handleUserListOpen(BuildContext context) {
    Get
        .toNamed(Routes.usersPage);
  }

  handleMallManageOpen(BuildContext context) {
    Get.toNamed(Routes.itemsManagePage);
  }

  handleGroundManageOpen(BuildContext context) {
    Get.toNamed(Routes.threadsManagePage);
  }
}
