import 'dart:html';
import 'dart:ui' as ui;

import 'package:after_layout/after_layout.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/execute/execute_code_bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/execute/execute_code_event.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/execute/execute_code_state.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/result/bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/upload/bloc.dart';
import 'package:code_running_front/business/user/models/request/req_execute_code_entity.dart';
import 'package:code_running_front/business/user/models/request/req_upload_code_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/ui/nav_util.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:codemirror/codemirror.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'get/bloc.dart';
import 'result/get_code_result_bloc.dart';

class CodingPage extends StatefulWidget {
  @override
  _CodingPageState createState() => _CodingPageState();
}

class _CodingPageState extends BaseLoadingPageState<CodingPage>
    with AfterLayoutMixin {
  GetCodeResultBloc _getCodeResultBloc;
  GetCodesBloc _getCodesBloc;
  UploadCodeBloc _uploadCodeBloc;
  ExecuteCodeBloc _executeCodeBloc;

  final String _editorId = "editor";

  Map _editorOptions = {
    'theme': 'monokai',
    'mode': 'python',
  };

  // web editor ui variables
  DivElement _codeContent = DivElement();
  CodeMirror _codeMirror;
  HtmlElementView _codeView;
  FocusNode focusNode = FocusNode();

  // TODO 后期改成static
  String _storeUrl;

//
//  var _textEditingController =
//      TextEditingController(text: DateTime.now().toString());

  @override
  void initState() {
    super.initState();
    // 注册codemirror标签
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(_editorId, (int viewId) => _codeContent);
    _codeView = HtmlElementView(
      viewType: _editorId,
    );
    // blocs
    _getCodeResultBloc = GetCodeResultBloc();
    _getCodesBloc = GetCodesBloc();
    _uploadCodeBloc = UploadCodeBloc();
    _executeCodeBloc = ExecuteCodeBloc();
  }

  @override
  void dispose() {
    _getCodeResultBloc?.close();
    _getCodesBloc?.close();
    _uploadCodeBloc?.close();
    _executeCodeBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("代码编辑器"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Wrap(
          spacing: 10,
          children: <Widget>[
            RawKeyboardListener(
              autofocus: true,
              focusNode: focusNode,
              child: Container(
                width: 400,
                height: 400,
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
            ),
            Container(
              width: 400,
              height: 400,
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      FlatButton.icon(
                          onPressed: () => handleStore,
                          icon: FaIcon(FontAwesomeIcons.save),
                          label: Text("保存至我的仓库")),
                      BlocBuilder(
                        bloc: _uploadCodeBloc,
                        builder: (BuildContext context, state) {
                          if (state is UploadCodeedState) {
                            _storeUrl = state.entity.data.url;
                            return FlatButton.icon(
                                onPressed: () => handleExe,
                                icon: FaIcon(FontAwesomeIcons.save),
                                label: Text("执行"));
                          }
                          if (state is NoUploadCodeState && state.msg != "") {
                            showError(msg: state.msg);
                          }
                          return FlatButton.icon(
                              onPressed: null,
                              icon: FaIcon(FontAwesomeIcons.save),
                              label: Text("执行"));
                        },
                      ),
                      FlatButton.icon(
                          onPressed: handleClose,
                          icon: FaIcon(FontAwesomeIcons.save),
                          label: Text("关闭编辑器"))
                    ],
                  ),
                  Expanded(
                      child: BlocListener(
                    bloc: _executeCodeBloc,
                    listener: (BuildContext context, state) {
                      if (state is ExecuteCodeedState) {
                        _getCodeResultBloc?.add(InGetCodeResultEvent(
                            ReqGetCodeResultEntity(state.entity.data.codeId)));
                      }
                    },
                    child: Container(
                      width: 400,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: BlocBuilder(
                        bloc: _getCodeResultBloc,
                        builder: (BuildContext context, state) {
                          if (state is InGetCodeResultState) {
                            return Text("已提交，等待服务器响应，请勿重复提交");
                          } else if (state is NoGetCodeResultState) {
                            return Text(state.msg);
                          } else if (state is InitialGetCodeResultState) {
                            return Text("请在代码写好后保存至仓库再执行");
                          } else if (state is GetCodeResultedState) {
                            return Text(
                              "${state.entity.data.status}: " +
                                  state.entity.data.result,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            );
                          }
                        },
                      ),
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  handleEditorCreated(CodeMirror mirror) {
    _codeMirror = mirror;
  }

  void handleStore() {
    _uploadCodeBloc?.add(InUploadCodeEvent(ReqUploadCodeEntity()
      ..fileName =
          getUserInfo().nickname + "-" + DateTime.now().toString() + ".py"
      ..content = _codeMirror?.getDoc()?.getValue()));
  }

  void handleClose() {
    NavUtil.navigator().pop();
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  void handleExe() {
    _executeCodeBloc
        ?.add(InExecuteCodeEvent(ReqExecuteCodeEntity()..url = _storeUrl));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    buildCodeMirror();
  }

  // TODO 失效了
  void buildCodeMirror() {
//    Future.delayed(const Duration(seconds: 1),(){
    var node;
//      while (true) {
    var array = document.getElementsByTagName("flt-platform-view");
    if (array.length != 0) {
      node = array[0] as HtmlElement;
//          break;
    }
//      }
    var headElement = HeadElement();
    final NodeValidatorBuilder _htmlValidator =
        new NodeValidatorBuilder.common()
          ..allowElement('link', attributes: ["rel", "href"])
          ..allowElement('script', attributes: ["src"]);
    rootBundle.loadString("assets/html/codemirror_header.html").then((value) {
      debugPrint("property: $value");
      debugPrint("options: $_editorOptions");
      headElement.setInnerHtml(value, validator: _htmlValidator);
      _codeMirror =
          CodeMirror.fromElement(_codeContent, options: _editorOptions);
      debugPrint("insert root");
      node.shadowRoot.children.insert(0, headElement);
      onEditorCreated(_codeMirror);
    });
//    });
  }

  void onEditorCreated(CodeMirror codeMirror) {}
}
