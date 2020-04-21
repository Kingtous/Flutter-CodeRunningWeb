import 'package:code_running_front/business/user/dashboard/modules/reset_password/reset_password/reset_password_event.dart';
import 'package:code_running_front/business/user/dashboard/modules/reset_password/send_reset_password_email/bloc.dart';
import 'package:code_running_front/business/user/models/request/req_reset_password_entity.dart';
import 'package:code_running_front/business/user/models/request/req_send_reset_password_mail_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';

import 'reset_password/reset_password_bloc.dart';
import 'send_reset_password_email/send_reset_password_mail_bloc.dart';

class FindBackPage extends StatefulWidget {
  @override
  _FindBackPageState createState() => _FindBackPageState();
}

class _FindBackPageState extends BaseLoadingPageState<FindBackPage> {
  var _textEditingController = TextEditingController();

  //全局 Key 用来获取 Form 表单组件
  GlobalKey<FormState> sendMailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  String username;

  SendResetPasswordMailBloc _bloc;
  ResetPasswordBloc _rbloc;

  bool isEmailOK = false;

  String code;

  String password;

  @override
  void initState() {
    super.initState();
    _bloc = SendResetPasswordMailBloc();
    _rbloc = ResetPasswordBloc();
    _bloc.listen((state) {
      if (state is SendResetPasswordMailedState) {
        setState(() {
          isEmailOK = true;
        });
        showSuccess(msg: "已发送邮箱验证码");
        hideLoadingDialog();
      } else if (state is NoSendResetPasswordMailState) {
        hideLoadingDialog();
        showError(msg: "没有对应的账户，请检查");
      }
    });
  }

  @override
  void dispose() {
    _bloc?.close();
    _rbloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("找回密码"),
      ),
      body: Stack(
        children: <Widget>[
          ImageLoadView("images/background/02.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              imageType: ImageType.assets,
              placeholder: "images/placeholders/black.jpg"),
          Container(
            padding: EdgeInsets.all(32),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 10,
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.all(32),
                    child: Form(
                        key: sendMailFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: '请输入用户名/邮箱',
                                hintText: "用户名/邮箱",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                                prefixIcon: Icon(Icons.person),
                              ),
                              //校验用户
                              validator: (value) {
                                return value.trim().length > 0
                                    ? null
                                    : "用户名不能为空";
                              },
                              //当 Form 表单调用保存方法 Save时回调的函数。
                              onSaved: (value) {
                                username = value;
                              },
                              // 当用户确定已经完成编辑时触发
                              onFieldSubmitted: (value) {},
                            ),
                            FlatButton(
                                onPressed:
                                    !isEmailOK ? handleEnteredUsername : null,
                                child: Text("确定"))
                          ],
                        )),
                  ),
                ),
                Offstage(
                  offstage: !isEmailOK,
                  child: Card(
                    elevation: 10,
                    child: Container(
                      width: 400,
                      height: 250,
                      padding: EdgeInsets.all(32),
                      child: Form(
                          key: resetPasswordFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: '请输入验证码',
                                  hintText: "6位验证码",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                  prefixIcon: Icon(Icons.call_missed_outgoing),
                                ),
                                //校验用户
                                validator: (value) {
                                  return value.trim().length == 6
                                      ? null
                                      : "验证码位数不对";
                                },
                                //当 Form 表单调用保存方法 Save时回调的函数。
                                onSaved: (value) {
                                  code = value;
                                },
                                // 当用户确定已经完成编辑时触发
                                onFieldSubmitted: (value) {},
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: '请输入新密码',
                                  hintText: "新密码",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                  prefixIcon: Icon(Icons.call_missed_outgoing),
                                ),
                                //校验用户
                                validator: (value) {
                                  return value.length >= 6 ? null : "密码不得少于6位";
                                },
                                obscureText: true,
                                //当 Form 表单调用保存方法 Save时回调的函数。
                                onSaved: (value) {
                                  password = value;
                                },
                                // 当用户确定已经完成编辑时触发
                                onFieldSubmitted: (value) {},
                              ),
                              FlatButton(
                                  onPressed: handleResetPassword,
                                  child: Text("确定"))
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleEnteredUsername() {
    var state = sendMailFormKey.currentState;
    if (state.validate()) {
      state.save();
      showLoadingDialog();
      _bloc?.add(InSendResetPasswordMailEvent(
          ReqSendResetPasswordMailEntity()..username = username));
    }
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  void handleResetPassword() {
    var state = resetPasswordFormKey.currentState;
    if (state.validate()) {
      state.save();
      showLoadingDialog();
      _rbloc?.add(InResetPasswordEvent(ReqResetPasswordEntity()
        ..code = code
        ..newPassword = password));
    }
  }
}
