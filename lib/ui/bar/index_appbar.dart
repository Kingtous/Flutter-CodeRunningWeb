import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class IndexAppBar extends StatefulWidget {
  @override
  _IndexAppBarState createState() => _IndexAppBarState();
}

class _IndexAppBarState extends State<IndexAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              child: TypewriterAnimatedTextKit(
            text: ["码上社区-Coder Community"],
            totalRepeatCount: 1,
            speed: Duration(milliseconds: 100),
            textStyle: TextStyle(fontSize: 24, color: Colors.white),
          ))
        ],
      ),
    );
  }
}
