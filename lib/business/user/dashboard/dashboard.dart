import 'dart:async';

import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/ui/nav_util.dart';
import 'package:code_running_front/utils/enum.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDashBoard extends StatefulWidget {
  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends BaseLoadingPageState<UserDashBoard> {
  @override
  Widget build(BuildContext context) {
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
          child: Stack(
            children: <Widget>[
              ImageLoadView(
                "images/background/02.jpg",
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          children: <Widget>[Expanded(child: buildMenu()), buildMoments()],
        ),
      );

  Widget buildMenu() =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.vertical,
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            buildMenuBtn(
                GestureDetector(
                  child: FaIcon(
                    FontAwesomeIcons.code,
                    size: 25,
                    color: Colors.white,
                  ),
                  onTap: () => {handleEditorOpen(context)},
                ),
                "我的编辑器",
                "开始创作"),
            buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.cloud,
                  size: 25,
                  color: Colors.white,
                ),
                "我的动态",
                "代码历史，帖子，评论"),
            buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.warehouse,
                  size: 25,
                  color: Colors.white,
                ),
                "论坛广场",
                "发现你的所见所闻"),
            buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.campground,
                  size: 25,
                  color: Colors.white,
                ),
                "干货广场",
                "学习使我快乐"),
            buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.store,
                  size: 25,
                  color: Colors.white,
                ),
                "我的商店",
                "看看今天都卖了啥"),
            buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.shoppingCart,
                  size: 25,
                  color: Colors.white,
                ),
                "我的购物车",
                "知识带回家"),
            buildMenuBtn(
                FaIcon(
                  FontAwesomeIcons.cogs,
                  size: 25,
                  color: Colors.white,
                ),
                "个人设置",
                "资料、密码、主页...")
          ],
        ),
      );

  /// 动态
  Widget buildMoments() =>
      Column(
        children: <Widget>[
          //时间面板
          FlutterAnalogClock(
            dateTime: DateTime.now(),
            dialPlateColor: Colors.white,
            hourHandColor: Colors.black,
            minuteHandColor: Colors.black,
            secondHandColor: Colors.black,
            numberColor: Colors.black,
            borderColor: Colors.black,
            tickColor: Colors.black,
            centerPointColor: Colors.black,
            showBorder: true,
            showTicks: true,
            showMinuteHand: true,
            showSecondHand: true,
            showNumber: true,
            borderWidth: 8.0,
            hourNumberScale: .10,
            hourNumbers: [
              'I',
              'II',
              'III',
              'IV',
              'V',
              'VI',
              'VII',
              'VIII',
              'IX',
              'X',
              'XI',
              'XII'
            ],
            isLive: true,
            width: 100,
            height: 100,
          )
        ],
      );

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
    NavUtil.navigator().pushNamed(Routes.codePage);
  }
}
