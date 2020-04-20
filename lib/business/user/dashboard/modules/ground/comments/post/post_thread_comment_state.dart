import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PostThreadCommentState extends Equatable {
  const PostThreadCommentState();
}

class InitialPostThreadCommentState extends PostThreadCommentState {
  @override
  List<Object> get props => [];
}

class NoPostThreadCommentState extends PostThreadCommentState {
  final String msg;

  NoPostThreadCommentState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InPostThreadCommentState extends PostThreadCommentState {
  @override
  List<Object> get props => [];
}

class PostThreadCommentedState extends PostThreadCommentState {
  final RespStatusEntity entity;

  PostThreadCommentedState(this.entity);

  @override
  List<Object> get props => [entity];
}
