import 'package:code_running_front/common/utils/px_utils.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class IndexAppBar extends StatefulWidget {
  @override
  _IndexAppBarState createState() => _IndexAppBarState();
}

class _IndexAppBarState extends State<IndexAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      padding: EdgeInsets.symmetric(horizontal: w(20), vertical: w(10)),
      child: Row(
        children: <Widget>[
          ControlledAnimation(
            duration: Duration(milliseconds: 5000),
            tween: Tween(begin: 0, end: w(1000)),
            builder: (context, num) {
              return Container(
                width: num,
                child: Text(
                  "码上社区-Coder Community",
                  style: TextStyle(fontSize: sp(40), color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
