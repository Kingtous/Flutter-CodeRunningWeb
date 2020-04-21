import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SendResetPasswordMailState extends Equatable {
  const SendResetPasswordMailState();
}

class InitialSendResetPasswordMailState extends SendResetPasswordMailState {
  @override
  List<Object> get props => [];
}

class NoSendResetPasswordMailState extends SendResetPasswordMailState {
  final String msg;

  NoSendResetPasswordMailState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InSendResetPasswordMailState extends SendResetPasswordMailState {
  @override
  List<Object> get props => [];
}

class SendResetPasswordMailedState extends SendResetPasswordMailState {
  final RespStatusEntity entity;

  SendResetPasswordMailedState(this.entity);

  @override
  List<Object> get props => [entity];
}
