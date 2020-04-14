import 'package:auto_route/auto_route.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadingDialog extends Dialog {
  String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: WillPopScope(
        child: new Center(
          //保证控件居中效果
            child: SingleChildScrollView(
              child: new SizedBox(
                width: 200,
                height: 200,
                child: new Container(
                  decoration: ShapeDecoration(
                    color: Color(0xff262626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: new FlareActor(
                          "animations/status/loading.flr",
                          animation: "spin2",
                        ),
                        width: 75,
                        height: 75,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(
                          top: 16,
                        ),
                        child: new Text(
                          text,
                          style: new TextStyle(
                              fontSize: 14.0, color: Color(0xffffffff)),
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(
                          top: 16,
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              ExtendedNavigator.ofRouter<Router>()
                                  .pop(),
                          child: new Text(
                            "取消",
                            style: new TextStyle(
                                fontSize: 12.0, color: Color(0xffffffff)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        onWillPop: () async => false,
      ),
    );
  }
}
