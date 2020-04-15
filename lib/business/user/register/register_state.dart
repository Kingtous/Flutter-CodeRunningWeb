import 'package:code_running_front/business/user/models/response/resp_register_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class NoRegisterState extends RegisterState {
  final String msg;

  NoRegisterState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisteredState extends RegisterState {
  final RespRegisterEntity entity;

  RegisteredState(this.entity);

  @override
  List<Object> get props => [entity];
}
