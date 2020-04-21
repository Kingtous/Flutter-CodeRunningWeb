import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();
}

class InitialResetPasswordState extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class NoResetPasswordState extends ResetPasswordState {
  final String msg;

  NoResetPasswordState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InResetPasswordState extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetPasswordedState extends ResetPasswordState {
  final RespStatusEntity entity;

  ResetPasswordedState(this.entity);

  @override
  List<Object> get props => [entity];
}
