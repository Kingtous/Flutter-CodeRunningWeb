import 'package:code_running_front/common/utils/image_utils.dart';
import 'package:code_running_front/common/utils/px_utils.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/third_libs_manager.dart';
import 'package:code_running_front/ui/bar/index_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_animations/simple_animations.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    ThirdLibsManager.get().adapterScreen(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          loadImageFullScreen(context, "images/background/01.jpg"),
          IndexAppBar(),
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ControlledAnimation(
                    duration: Duration(milliseconds: 1000),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, num) {
                      return Opacity(
                        opacity: num,
                        child: Text(
                          "码上社区",
                          style: TextStyles.textStyle(fontSize: sp(42)),
                        ),
                      );
                    },
                  ),
                  Gaps.vGap(h(10)),
                  ControlledAnimation(
                    duration: Duration(milliseconds: 1500),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, num) {
                      return Opacity(
                        opacity: num,
                        child: Text(
                          "无限创作，分享你的创造力",
                          style: TextStyles.textStyle(fontSize: sp(42)),
                        ),
                      );
                    },
                  ),
                  Gaps.vGap(h(50)),
                  FlatButton(
                      padding: EdgeInsets.all(w(20)),
                      shape: StadiumBorder(),
                      color: Colors.indigo,
                      child: Text("进入社区",
                          style: TextStyles.textStyle(fontSize: sp(24))),
                      onPressed: handleEnter),
                  Gaps.vGap(h(100)),
                  ControlledAnimation(
                    duration: Duration(milliseconds: 1500),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (c, n) =>
                        Opacity(
                          opacity: n,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              introCards(
                                  "随心",
                                  "传统OJ平台只执行题目解答，而你可以在这里随时随地编写属于你自己的项目，而无需担心地点原因！",
                                  FaIcon(FontAwesomeIcons.accessibleIcon,
                                      size: w(50))
                              ),
                              Gaps.hGap(w(100)),
                              introCards(
                                  "分享", "向全社区的用户分享你的新创意，并赢取社区积分，成为社区支柱！",
                                  FaIcon(FontAwesomeIcons.shareSquare, size: w(
                                      50),)
                              ),
                              Gaps.hGap(w(100)),
                              introCards(
                                  "开源", "项目完全开源，隐私性得以保证，并提供丰富的API支持！",
                                  FaIcon(FontAwesomeIcons.doorOpen, size: w(50))
                              )
                            ],
                          ),
                        ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void handleEnter() {

  }


  Widget introCards(String title, String content, FaIcon icon) {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        margin: EdgeInsets.all(h(20)),
        width: w(250),
        height: h(300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Gaps.vGap(h(50)),
            icon,
            Gaps.vGap(h(50)),
            Text(title, overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              softWrap: true,),
            Gaps.vGap(h(25)),
            Text(content, overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                softWrap: true),
          ],
        ),
      ),
    );
  }
}
