import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/utils/enum.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:flutter/material.dart';
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
          child: ImageLoadView(
        "images/background/02.jpg",
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        placeholder: "images/placeholders/black.jpg",
            imageType: ImageType.assets,
      )),
    );
  }

  void handleExit() {
    logOut();
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }
}
