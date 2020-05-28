import 'package:code_running_front/business/user/models/request/req_thread_comment_entity.dart';

reqThreadCommentEntityFromJson(
    ReqThreadCommentEntity data, Map<String, dynamic> json) {
  if (json['thread_id'] != null) {
    data.threadId = json['thread_id']?.toInt();
  }
  if (json['content'] != null) {
    data.content = json['content']?.toString();
  }
  return data;
}

Map<String, dynamic> reqThreadCommentEntityToJson(
    ReqThreadCommentEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['thread_id'] = entity.threadId;
  data['content'] = entity.content;
  return data;
}