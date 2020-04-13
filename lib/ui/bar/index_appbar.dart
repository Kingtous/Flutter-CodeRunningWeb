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
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          ControlledAnimation(
            duration: Duration(milliseconds: 5000),
            tween: Tween(begin: 0, end: MediaQuery
                .of(context)
                .size
                .width),
            builder: (context, num) {
              return Container(
                width: num,
                child: Text(
                  "码上社区-Coder Community",
                  style: TextStyle(fontSize: 24, color: Colors.white),
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
