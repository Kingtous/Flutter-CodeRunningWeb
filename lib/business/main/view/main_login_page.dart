import 'package:code_running_front/common/utils/px_utils.dart';
import 'package:code_running_front/ui/code_editor.dart';
import 'package:codemirror/codemirror.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart';

class MainLoginPage extends StatefulWidget {
  final int networkId;
  final int timestamps;

  const MainLoginPage(this.networkId, this.timestamps);

  @override
  _MainLoginPageState createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  // UI变量
  String _codemirrorId = "code-edit";
  Map options = {'mode': 'clike', 'theme': 'monokai'};
  CodeMirror _codeMirror;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "码上登录",
            style: TextStyle(fontSize: sp(42)),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: CodeEditor(
          editorId: _codemirrorId,
          height: 800,
          width: 400,
          initialOptions: options,
          onEditorCreated: (CodeMirror mirror) {
            _codeMirror = mirror;
          },
        ));
  }
}
