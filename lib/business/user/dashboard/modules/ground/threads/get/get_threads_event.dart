import 'package:code_running_front/business/user/models/request/req_get_threads_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetThreadsEvent extends Equatable {
  const GetThreadsEvent();
}

class InGetThreadsEvent extends GetThreadsEvent {
  final ReqGetThreadsEntity entity;

  InGetThreadsEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
