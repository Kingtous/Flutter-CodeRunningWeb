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

  const CodeEditor(
      {Key key,
      @required this.onEditorCreated,
      @required this.width,
      @required this.height,
      @required this.editorId,
      @required this.initialOptions})
      : super(key: key);

  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> with AfterLayoutMixin {
  DivElement _codeContent = DivElement();
  CodeMirror _codeMirror;
  HtmlElementView _codeView;
  FocusNode focusNode = FocusNode();

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
  }

  @override
  void dispose() {
    _codeMirror?.dispose();
    focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    document.onKeyDown.listen((event) {
      if (event.which == 9) {
        debugPrint("prevent");
        event.preventDefault();
      }
    });
    return RawKeyboardListener(
      autofocus: true,
      focusNode: focusNode,
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
    var node =
        document.getElementsByTagName("flt-platform-view")[0] as HtmlElement;
    var headElement = HeadElement();
    final NodeValidatorBuilder _htmlValidator =
        new NodeValidatorBuilder.common()
          ..allowElement('link', attributes: ["rel", "href"])
          ..allowElement('script', attributes: ["src"]);
    rootBundle.loadString("assets/html/codemirror_header.html").then((value) {
      headElement.setInnerHtml(value, validator: _htmlValidator);
      _codeMirror =
          CodeMirror.fromElement(_codeContent, options: widget.initialOptions);
      node.shadowRoot.children.insert(0, headElement);
      widget.onEditorCreated(_codeMirror);
    });
  }
}
