import 'package:code_running_front/business/user/models/response/resp_get_threads_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetThreadsState extends Equatable {
  const GetThreadsState();
}

class InitialGetThreadsState extends GetThreadsState {
  @override
  List<Object> get props => [];
}

class NoGetThreadsState extends GetThreadsState {
  final String msg;

  NoGetThreadsState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InGetThreadsState extends GetThreadsState {
  @override
  List<Object> get props => [];
}

class GetThreadsedState extends GetThreadsState {
  final RespGetThreadsEntity entity;

  GetThreadsedState(this.entity);

  @override
  List<Object> get props => [entity];
}
