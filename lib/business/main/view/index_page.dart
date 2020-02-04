import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "主界面",
          style: TextStyles.textWhite12,
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Container(
          child: CupertinoButton(
            child: Text("登录"),
            onPressed: () {
              Navigator.of(context).pushNamed(Router.loginRoute,
                  arguments: MainLoginPageArguments(
                      networkId: 1,
                      timestamps: DateTime.now().millisecondsSinceEpoch));
            },
          ),
        ),
      ),
    );
  }
}
