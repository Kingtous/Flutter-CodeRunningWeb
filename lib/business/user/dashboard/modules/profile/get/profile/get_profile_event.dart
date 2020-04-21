import 'package:code_running_front/business/user/models/request/req_get_profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetProfileEvent extends Equatable {
  const GetProfileEvent();
}

class InGetProfileEvent extends GetProfileEvent {
  final ReqGetProfileEntity entity;

  InGetProfileEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
