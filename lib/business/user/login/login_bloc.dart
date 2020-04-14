import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_login_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => NoLoginState(msg: "");

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is InLoginEvent) {
      yield* mapInLoginEvent(event);
    }
  }

  Stream<LoginState> mapInLoginEvent(InLoginEvent event) async* {
    yield InLoginState();
    var callback = await ApiRequest.login(event.entity);
    if (callback != null) {
      RespLoginEntity entity = callback.data;
      if (entity != null) {
        if (entity.code == 0) {
          yield LoginedState(entity);
        } else {
          yield NoLoginState(msg: getErrMsg(entity.code));
        }
      } else {
        yield NoLoginState(msg: "登录失败");
      }
    } else {
      yield NoLoginState(msg: "登录失败");
    }
  }
}
