import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_running_front/business/user/models/request/req_register_entity.dart';
import 'package:code_running_front/business/user/register/bloc.dart';
import 'package:code_running_front/business/user/register/register_bloc.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/ui/typewriter_text.dart';
import 'package:code_running_front/utils/enum.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:code_running_front/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRegisterPage extends StatefulWidget {
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends BaseLoadingPageState<UserRegisterPage> {
  //全局 Key 用来获取 Form 表单组件
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  RegisterBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = RegisterBloc();
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }

  String username;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (BuildContext context, state) {
        if (state is InRegisterState) {
          showLoading(msg: "正在请求");
        } else {
          closeLoading();
        }
        if (state is NoRegisterState && state.msg.length != 0) {
          showError(msg: state.msg);
        }
        if (state is RegisteredState) {
          showSuccess(msg: "注册成功");
          Timer(
              Duration(seconds: 2),
              () => saveUserRegisterData(state.entity.data).then((value) =>
                  ExtendedNavigator.ofRouter<Router>().pushNamedAndRemoveUntil(
                      Routes.userDashBoard, (route) => false)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: TypeWriterText(
            ["注册你的账号"],
            style: TextStyles.textWhite14,
          ),
        ),
        body: Stack(
          children: <Widget>[
            ImageLoadView("images/background/02.jpg",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                imageType: ImageType.assets,
                placeholder: "images/placeholders/black.jpg"),
            Center(
              child: Card(
                elevation: 10,
                child: Container(
                  width: 400,
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: registerKey,
                    autovalidate: true,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("账号注册"),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: '请输入用户名',
                            hintText: "用户名",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                          //校验用户
                          validator: (value) {
                            return value.trim().length > 0 ? null : "用户名不能为空";
                          },
                          //当 Form 表单调用保存方法 Save时回调的函数。
                          onSaved: (value) {
                            username = value;
                          },
                          // 当用户确定已经完成编辑时触发
                          onFieldSubmitted: (value) {},
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: '请输入邮箱（用于密码重置等）',
                            hintText: "example@kingtous.cn",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                          //校验用户
                          validator: (value) {
                            return Utils.isEmail(value.trim())
                                ? null
                                : "邮箱格式不正确";
                          },
                          //当 Form 表单调用保存方法 Save时回调的函数。
                          onSaved: (value) {
                            email = value;
                          },
                          // 当用户确定已经完成编辑时触发
                          onFieldSubmitted: (value) {},
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: '请输入密码',
                            hintText: '你的登录密码',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          //是否是密码
                          obscureText: true,
                          //校验密码
                          validator: (value) {
                            return value.length < 6 ? '密码长度不够 6 位' : null;
                          },
                          onSaved: (value) {
                            password = value;
                          },
                        ),
                        Gaps.vGap(16),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton.icon(
                                  color: Colors.black,
                                  onPressed: handleRegister,
                                  hoverColor: Colors.grey,
                                  icon: Icon(
                                    Icons.add_box,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "注册",
                                    style: TextStyles.textWhite14,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleRegister() {
    var state = registerKey.currentState;
    if (state.validate()) {
      state.save();
      _bloc?.add(InRegisterEvent(ReqRegisterEntity()
        ..username = username
        ..password = password
        ..mail = email));
    }
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }
}
