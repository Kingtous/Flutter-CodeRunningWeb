import 'package:code_running_front/business/user/models/response/resp_login_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

// 未登录
class NoLoginState extends LoginState {
  final String msg;

  NoLoginState({this.msg = "未知错误"});

  @override
  List<Object> get props => [msg];
}

// 正在登录
class InLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

// 已经登录
class LoginedState extends LoginState {
  final RespLoginEntity entity;

  LoginedState(this.entity);

  @override
  List<Object> get props => [entity];
}
