import 'package:code_running_front/business/user/models/response/resp_get_thread_comment_entity.dart';

respGetThreadCommentEntityFromJson(RespGetThreadCommentEntity data,
    Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<RespGetThreadCommentData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new RespGetThreadCommentData().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> respGetThreadCommentEntityToJson(
    RespGetThreadCommentEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  return data;
}

respGetThreadCommentDataFromJson(RespGetThreadCommentData data,
    Map<String, dynamic> json) {
  if (json['code_url'] != null) {
    data.codeUrl = json['code_url']?.toString();
  }
  if (json['content'] != null) {
    data.content = json['content']?.toString();
  }
  if (json['create_date'] != null) {
    data.createDate = json['create_date']?.toDouble();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['next_id'] != null) {
    data.nextId = json['next_id'];
  }
  if (json['parent_id'] != null) {
    data.parentId = json['parent_id']?.toInt();
  }
  if (json['threads_id'] != null) {
    data.threadsId = json['threads_id']?.toInt();
  }
  if (json['user_id'] != null) {
    data.userId = json['user_id']?.toInt();
  }
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  return data;
}

Map<String, dynamic> respGetThreadCommentDataToJson(
    RespGetThreadCommentData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code_url'] = entity.codeUrl;
  data['content'] = entity.content;
  data['create_date'] = entity.createDate;
  data['id'] = entity.id;
  data['next_id'] = entity.nextId;
  data['parent_id'] = entity.parentId;
  data['threads_id'] = entity.threadsId;
  data['user_id'] = entity.userId;
  data['username'] = entity.username;
  return data;
}