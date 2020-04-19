import 'dart:async';
import 'dart:js';
import 'dart:ui' as ui;

import 'package:after_layout/after_layout.dart';
import 'package:codemirror/codemirror.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart';

class CodeEditor extends StatefulWidget {
  final Function(CodeMirror) onEditorCreated;
  final double width;
  final double height;
  final String editorId;
  final Map initialOptions;
  final FocusNode focusNode;

  const CodeEditor(
      {Key key,
      @required this.onEditorCreated,
      @required this.width,
      @required this.height,
      @required this.editorId,
      @required this.initialOptions, this.focusNode})
      : super(key: key);

  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> with AfterLayoutMixin {
  DivElement _codeContent = DivElement();
  CodeMirror _codeMirror;
  HtmlElementView _codeView;

  @override
  void initState() {
    super.initState();
    // 注册codemirror标签
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(widget.editorId, (int viewId) => _codeContent);
    _codeView = HtmlElementView(
      viewType: widget.editorId,
    );
    // 禁止tab键
    document.onKeyDown.listen((event) {
      if (event.keyCode == 9) {
        event.preventDefault();
      }
    });
  }

  @override
  void dispose() {
    _codeMirror?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: widget.focusNode,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: _codeView,
      ),
      onKey: (RawKeyEvent event) {
        if (event.runtimeType == RawKeyDownEvent &&
            (event.logicalKey.keyId == KeyCode.SPACE ||
                event.logicalKey.keyId == KeyCode.TAB)) {
          _codeMirror.focus();
          debugPrint("focus!");
        }
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    buildCodeMirror();
  }

  void buildCodeMirror() {
    var headElement = HeadElement();
    final NodeValidatorBuilder _htmlValidator =
        new NodeValidatorBuilder.common()
          ..allowElement('link', attributes: ["rel", "href"])
          ..allowElement('script', attributes: ["src"]);
    rootBundle.loadString("assets/html/codemirror_header.html").then((value) {
      // create codeMirror
      _codeMirror =
          CodeMirror.fromElement(_codeContent, options: widget.initialOptions);
      debugPrint("insert root");
      widget.onEditorCreated(_codeMirror);
      // add headers
      debugPrint("property: $value");
      debugPrint("options: ${widget.initialOptions.toString()}");
      headElement.setInnerHtml(value, validator: _htmlValidator);
      // 查找
      Future.delayed(const Duration(milliseconds: 500), () {
        var node;
        while (true) {
          var array = document.getElementsByTagName("flt-platform-view");
          if (array.length != 0) {
            node = array[0] as HtmlElement;
            break;
          }
        }
        node.shadowRoot.children.insert(0, headElement);
      });
    });
  }
}
