import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SendRegisterEmailState extends Equatable {
  const SendRegisterEmailState();
}

class InitialSendRegisterEmailState extends SendRegisterEmailState {
  @override
  List<Object> get props => [];
}

class NoSendRegisterEmailState extends SendRegisterEmailState {
  final String msg;

  NoSendRegisterEmailState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InSendRegisterEmailState extends SendRegisterEmailState {
  @override
  List<Object> get props => [];
}

class SendRegisterEmailedState extends SendRegisterEmailState {
  final RespStatusEntity entity;

  SendRegisterEmailedState(this.entity);

  @override
  List<Object> get props => [entity];
}
