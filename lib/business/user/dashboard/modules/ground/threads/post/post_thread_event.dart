import 'package:code_running_front/business/user/models/request/req_post_thread_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PostThreadEvent extends Equatable {
  const PostThreadEvent();
}

class InPostThreadEvent extends PostThreadEvent {
  final ReqPostThreadEntity entity;

  InPostThreadEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
