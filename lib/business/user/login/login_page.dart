import 'package:auto_route/auto_route.dart';
import 'package:code_running_front/business/user/login/bloc.dart';
import 'package:code_running_front/business/user/models/request/req_login_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/common/network/image_constants.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/ui/seven_textfield.dart';
import 'package:code_running_front/ui/typewriter_text.dart';
import 'package:code_running_front/utils/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final int networkId;
  final int timestamps;

  const LoginPage(this.networkId, this.timestamps);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseLoadingPageState<LoginPage> {
  LoginBloc _loginBloc;

  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  List<String> tips = ["码上社区登录界面", "请输入你的账号名和密码"];
  String _loginMsg = "";

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    _loginBloc.add(IsLoginEvent());
  }

  @override
  void dispose() {
    _loginBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: handleLoginBlocChanged,
      condition: (prev, curr) {
        if (prev is InLoginState && curr is NoLoginState) {
          ExtendedNavigator.ofRouter<Router>().pop();
          setState(() {
            _loginMsg = curr.msg;
          });
        }
        if (prev is! LoginedState && curr is LoginedState) {
          ExtendedNavigator.ofRouter<Router>().pop();
          setState(() {
            _loginMsg = "登录成功";
          });
        }
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              "码上登录",
              style: TextStyle(fontSize: 16),
            ),
//            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: <Widget>[
              ImageLoadView("images/background/03.jpg",
                  imageType: ImageType.assets,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  fit: BoxFit.cover,
                  placeholder: "images/placeholders/black.jpg"),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Gaps.vGap(50),
                    TypeWriterText(
                      tips,
                      style: TextStyles.textStyle(fontSize: 30),
                    ),
                    Gaps.vGap(50),
                    Container(
                      alignment: Alignment.center,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 100,
                        runSpacing: 50,
                        children: <Widget>[
                          ImageLoadView(loginLeftImageUrl,
                              width: 200,
                              height: 200,
                              placeholder: "images/placeholders/black.jpg"),
//                    Gaps.hGap(100),
                          Card(
                            elevation: 10,
                            color: Colors.white,
                            child: Container(
                              width: 400,
                              height: 400,
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: TypeWriterText(
                                            ["登录"],
                                            style: TextStyles.textBoldDark20,
                                          )),
                                      TypeWriterText(
                                        ["点此注册"],
                                        style: TextStyles.textDark14,
                                        onTap: handleRegister,
                                      )
                                    ],
                                  ),
                                  Gaps.vGap(30),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SevenTextField(
                                        width: 350,
                                        height: 100,
                                        onChanged: handleUserNameChanged,
                                        textEditingController:
                                        userNameController,
                                        isPassword: false,
                                        onEditComplete: () {},
                                        labelText: "用户名/邮箱",
                                        icon: Icon(Icons.person_outline),
                                      ),
                                      SevenTextField(
                                        width: 350,
                                        height: 100,
                                        onChanged: handlePasswordChanged,
                                        textEditingController:
                                        passwordController,
                                        isPassword: true,
                                        onEditComplete: () {},
                                        labelText: "密码",
                                        icon: Icon(Icons.lock),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                              child: Offstage(
                                                  offstage: _loginMsg.length ==
                                                      0,
                                                  child: Text(_loginMsg,
                                                    style: TextStyles
                                                        .textRed14,)),
                                            ),
                                            FlatButton(
                                              child: Text(
                                                "忘记密码",
                                                style: TextStyles.textDark16,
                                              ),
                                              onPressed: handleForgetPassword,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 400,
                                        child: FlatButton(
                                          child: Text(
                                            "登录",
                                            style: TextStyles.textWhite16,
                                          ),
                                          onPressed: handleLogin,
                                          focusColor: Colors.grey,
                                          hoverColor: Colors.grey,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  void handleRegister() {}

  void handleLoginBlocChanged(BuildContext context, LoginState state) {
    if (state is InLoginState) {
      // 正在加载
      showLoading(msg: "正在请求中");
    }
  }

  String username = "";

  handleUserNameChanged(String text) {
    username = text;
  }

  String password = "";

  handlePasswordChanged(String text) {
    password = text;
  }

  void handleForgetPassword() {}

  void handleLogin() {
    _loginBloc?.add(InLoginEvent(ReqLoginEntity()
      ..username = username
      ..password = password));
  }

  @override
  void preparedPage() {}
}
