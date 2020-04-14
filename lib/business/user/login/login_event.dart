import 'package:code_running_front/business/user/models/request/req_login_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

// 检查是否登录
class IsLoginEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

// 登录
class InLoginEvent extends LoginEvent {
  final ReqLoginEntity entity;

  InLoginEvent(this.entity);

  @override
  List<Object> get props => [entity];
}

// 注销
class LogOutEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
