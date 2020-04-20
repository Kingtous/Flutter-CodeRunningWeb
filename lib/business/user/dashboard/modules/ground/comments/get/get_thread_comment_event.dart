import 'package:code_running_front/business/user/models/request/req_get_thread_comment_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetThreadCommentEvent extends Equatable {
  const GetThreadCommentEvent();
}

class InGetThreadCommentEvent extends GetThreadCommentEvent {
  final ReqGetThreadCommentEntity entity;

  InGetThreadCommentEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
