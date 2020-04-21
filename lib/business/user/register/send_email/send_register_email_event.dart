import 'package:code_running_front/business/user/models/request/req_send_register_email_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SendRegisterEmailEvent extends Equatable {
  const SendRegisterEmailEvent();
}

class InSendRegisterEmailEvent extends SendRegisterEmailEvent {
  final ReqSendRegisterEmailEntity entity;

  InSendRegisterEmailEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
