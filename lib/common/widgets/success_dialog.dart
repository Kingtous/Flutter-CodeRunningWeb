import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SuccessDialog extends Dialog {
  String text;

  SuccessDialog({Key key, @required this.text}) : super(key: key);

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
            width: 250,
            height: 250,
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
                      "assets/animations/status/okay.flr",
                      animation: "okay",
                    ),
                    width: 75,
                    height: 75,
                  ),
                  new Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: new Text(
                      text,
                      style: new TextStyle(
                          fontSize: 12.0, color: Color(0xffffffff)),
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
