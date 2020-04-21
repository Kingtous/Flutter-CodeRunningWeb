import 'package:code_running_front/business/user/models/request/req_reset_password_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class InResetPasswordEvent extends ResetPasswordEvent {
  final ReqResetPasswordEntity entity;

  InResetPasswordEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
