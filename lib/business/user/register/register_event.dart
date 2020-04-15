import 'package:code_running_front/business/user/models/request/req_register_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class InRegisterEvent extends RegisterEvent {
  final ReqRegisterEntity entity;

  InRegisterEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
