import 'package:code_editor/code_editor.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/execute/execute_code_bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/execute/execute_code_event.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/execute/execute_code_state.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/result/bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/code/upload/bloc.dart';
import 'package:code_running_front/business/user/models/request/req_execute_code_entity.dart';
import 'package:code_running_front/business/user/models/request/req_upload_code_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/ui/nav_util.dart';
import 'package:code_running_front/utils/enum.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'get/bloc.dart';
import 'result/get_code_result_bloc.dart';

class CodingPage extends StatefulWidget {
  @override
  _CodingPageState createState() => _CodingPageState();
}

class _CodingPageState extends BaseLoadingPageState<CodingPage> {
  GetCodeResultBloc _getCodeResultBloc;
  GetCodesBloc _getCodesBloc;
  UploadCodeBloc _uploadCodeBloc;
  ExecuteCodeBloc _executeCodeBloc;

  final String _editorId = "coding-editor";

  Map _editorOptions = {
    'theme': 'default',
    'mode': 'python',
    'styleActiveLine': true,
    'indentWithTabs': false,
    'autoCloseTags': true,
    'extraKeys': {
      'Ctrl-Space': 'autocomplete',
      'Cmd-/': 'toggleComment',
      'Ctrl-/': 'toggleComment'
    }
  };

  // TODO 后期改成static
  String _storeUrl;
  String _codeType = "C++";

  var _colNumbers = 0;
  var _lineNumbers = 0;

  var _focusNode = FocusNode();

//
//  var _textEditingController =
//      TextEditingController(text: DateTime.now().toString());

  FileEditor _editor = FileEditor(name: "tmp.cpp", language: "cpp", code: "");

  EditorModel model;

  var _ceKey = UniqueKey();

  var _editorWidget = CodeEditor();

  @override
  void initState() {
    super.initState();
    // blocs
    _getCodeResultBloc = GetCodeResultBloc();
    _getCodesBloc = GetCodesBloc();
    _uploadCodeBloc = UploadCodeBloc();
    _executeCodeBloc = ExecuteCodeBloc();

    model = new EditorModel(
      files: [_editor], // the files created above
      // you can customize the editor as you want
      styleOptions: new EditorModelStyleOptions(
        fontSize: 13,
      ),
    );
    _editorWidget = CodeEditor(
      key: _ceKey,
      model: model,
      edit: true,
      disableNavigationbar: false,
      onSubmit: (language, value) {
        // TODO handle
        debugPrint("on save");
      },
    );
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
    super.build(context);
    debugPrint("rebuild coding page");
    return Scaffold(
      appBar: AppBar(
        title: Text("代码编辑器"),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          ImageLoadView(
            "images/background/02.jpg",
            imageType: ImageType.assets,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            child: Card(
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("代码语言"),
                            Gaps.hGap(16.0),
                            DropdownButton(
                                items: <String>["C++", "Java", "Python3"]
                                    .map((String e) =>
                                    DropdownMenuItem<String>(
                                        child: Text(e), value: e))
                                    .toList(),
                                value: _codeType,
                                onChanged: handleCodeTypeChanged),
                            Gaps.hGap(4.0),
                          ],
                        ),
                      ],
                    ),
                    _editorWidget,
                    Container(
                      // width: 400,
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          Wrap(
                            children: <Widget>[
                              BlocListener(
                                bloc: _uploadCodeBloc,
                                listener: (BuildContext context, state) {
                                  if (state is UploadCodeedState) {
                                    _storeUrl = state.entity.data.url;
                                    showSuccess(msg: "上传成功！");
                                  }
                                },
                                child: FlatButton.icon(
                                    onPressed: handleStore,
                                    icon: FaIcon(FontAwesomeIcons.save),
                                    label: Text("1.保存")),
                              ),
                              BlocListener(
                                bloc: _uploadCodeBloc,
                                listener: (BuildContext context, state) {
                                  if (state is UploadCodeedState) {
                                    setState(() {
                                      _storeUrl = state.entity.data.url;
                                    });
                                  }
                                },
                                child: FlatButton.icon(
                                    onPressed:
                                    _storeUrl != null ? handleExe : null,
                                    icon: FaIcon(FontAwesomeIcons.autoprefixer),
                                    label: Text("2.执行")),
                              )
                            ],
                          ),
                          BlocListener(
                            bloc: _executeCodeBloc,
                            listener: (BuildContext context, state) {
                              if (state is ExecuteCodeedState) {
                                Future.delayed(Duration(milliseconds: 500), () {
                                  _getCodeResultBloc?.add(InGetCodeResultEvent(
                                      ReqGetCodeResultEntity(
                                          state.entity.data.codeId)));
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(color: Colors.grey),
                              child: BlocBuilder(
                                bloc: _getCodeResultBloc,
                                builder: (BuildContext context, state) {
                                  if (state is InGetCodeResultState) {
                                    return Text("已提交，等待服务器响应");
                                  } else if (state is NoGetCodeResultState) {
                                    return Text(state.msg);
                                  } else if (state
                                  is InitialGetCodeResultState) {
                                    return Text("执行结果显示处：\n请在代码写好后保存至仓库再执行");
                                  } else if (state is GetCodeResultedState) {
                                    return Text(
                                      "状态：${getStateStr(
                                          state.entity.data.status)} \n\n" +
                                          state.entity.data.result,
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    );
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  handleEditorCreated() {}

  String getPrefix() {
    debugPrint("当前扩展名$_codeType");
    if (_codeType == "Python3") {
      return ".py";
    } else if (_codeType == "Java") {
      return ".java";
    } else {
      return ".cpp";
    }
  }

  void handleStore() {
    _uploadCodeBloc?.add(InUploadCodeEvent(ReqUploadCodeEntity()
      ..fileName =
          getUserInfo().nickname + "-" + DateTime.now().toString() + getPrefix()
      ..content = _editor.code));
  }

  void handleClose() {
    NavUtil.navigator().pop();
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  void handleExe() {
    debugPrint("exe:$_storeUrl");
    _executeCodeBloc
        ?.add(InExecuteCodeEvent(ReqExecuteCodeEntity()
      ..url = _storeUrl));
  }

  void handleCodeTypeChanged(String value) {
    if (value == "Python3") {
      debugPrint("switch python");
      // _codeMirror?.setMode("python");
    } else {
      debugPrint("switch clike");
      // _codeMirror?.setMode("clike");
    }
    setState(() {
      _codeType = value;
      _editor = FileEditor(
          code: _editor.code, language: value, name: "tmp" + getPrefix());
      model = EditorModel(files: [_editor]);
      _editorWidget = CodeEditor(
        key: _ceKey,
        model: model,
        edit: true,
        disableNavigationbar: false,
        onSubmit: (language, value) {
          // TODO handle
          debugPrint("on save");
        },
      );
    });
  }
}
