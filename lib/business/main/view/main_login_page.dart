import 'package:code_running_front/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rich_code_editor/code_editor/widgets/code_editable_text.dart';
import 'package:rich_code_editor/code_editor/widgets/code_text_field.dart';
import 'package:rich_code_editor/rich_code_editor.dart';

class MainLoginPage extends StatefulWidget {
  final int networkId;
  final int timestamps;

  const MainLoginPage(this.networkId, this.timestamps);

  @override
  _MainLoginPageState createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  CodeEditingController _codeEditingController = new CodeEditingController();

  // UI变量
  String _codeDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "登录界面",
          style: TextStyles.textWhite12,
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("登录时间（时间戳）：" + widget.timestamps.toString()),
            Text("ID：" + widget.networkId.toString()),
            Container(
              width: 0.8 * MediaQuery.of(context).size.width,
              height: 200,
              child: CodeTextField(
                highlighter: DummyHighlighter(),
                controller: _codeEditingController,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                onChanged: (s) {
                  _codeDetail = s;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
