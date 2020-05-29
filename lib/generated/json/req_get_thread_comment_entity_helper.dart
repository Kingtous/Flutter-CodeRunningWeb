import 'package:code_running_front/business/user/models/request/req_get_thread_comment_entity.dart';

reqGetThreadCommentEntityFromJson(ReqGetThreadCommentEntity data,
    Map<String, dynamic> json) {
  if (json['thread_id'] != null) {
    data.threadId = json['thread_id']?.toInt();
  }
  if (json['page'] != null) {
    data.page = json['page']?.toInt();
  }
  return data;
}

Map<String, dynamic> reqGetThreadCommentEntityToJson(
    ReqGetThreadCommentEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['thread_id'] = entity.threadId;
  data['page'] = entity.page;
  return data;
}