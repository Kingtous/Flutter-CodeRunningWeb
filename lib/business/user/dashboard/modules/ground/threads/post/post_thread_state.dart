import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PostThreadState extends Equatable {
  const PostThreadState();
}

class InitialPostThreadState extends PostThreadState {
  @override
  List<Object> get props => [];
}

class NoPostThreadState extends PostThreadState {
  final String msg;

  NoPostThreadState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InPostThreadState extends PostThreadState {
  @override
  List<Object> get props => [];
}

class PostThreadedState extends PostThreadState {
  final RespStatusEntity entity;

  PostThreadedState(this.entity);

  @override
  List<Object> get props => [entity];
}
