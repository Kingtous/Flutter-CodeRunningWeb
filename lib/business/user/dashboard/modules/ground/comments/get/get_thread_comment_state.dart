import 'package:code_running_front/business/user/models/response/resp_get_thread_comment_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetThreadCommentState extends Equatable {
  const GetThreadCommentState();
}

class InitialGetThreadCommentState extends GetThreadCommentState {
  @override
  List<Object> get props => [];
}

class NoGetThreadCommentState extends GetThreadCommentState {
  final String msg;

  NoGetThreadCommentState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InGetThreadCommentState extends GetThreadCommentState {
  @override
  List<Object> get props => [];
}

class GetThreadCommentedState extends GetThreadCommentState {
  final RespGetThreadCommentEntity entity;

  GetThreadCommentedState(this.entity);

  @override
  List<Object> get props => [entity];
}
