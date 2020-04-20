import 'package:code_running_front/business/user/models/request/req_get_repository_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetRepositoryEvent extends Equatable {
  const GetRepositoryEvent();
}

class InGetRepositoryEvent extends GetRepositoryEvent {
  final ReqGetRepositoryEntity entity;

  InGetRepositoryEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
