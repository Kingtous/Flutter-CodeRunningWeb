import 'package:code_running_front/business/user/models/request/req_send_reset_password_mail_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SendResetPasswordMailEvent extends Equatable {
  const SendResetPasswordMailEvent();
}

class InSendResetPasswordMailEvent extends SendResetPasswordMailEvent {
  final ReqSendResetPasswordMailEntity entity;

  InSendResetPasswordMailEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
