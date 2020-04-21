import 'package:code_running_front/business/user/models/request/req_alter_profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AlterProfileEvent extends Equatable {
  const AlterProfileEvent();
}

class InAlterProfileEvent extends AlterProfileEvent {
  final ReqAlterProfileEntity entity;

  InAlterProfileEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
