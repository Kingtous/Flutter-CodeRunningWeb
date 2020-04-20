import 'package:code_running_front/business/user/models/request/req_thread_comment_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PostThreadCommentEvent extends Equatable {
  const PostThreadCommentEvent();
}

class InPostThreadCommentEvent extends PostThreadCommentEvent {
  final ReqThreadCommentEntity entity;

  InPostThreadCommentEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
