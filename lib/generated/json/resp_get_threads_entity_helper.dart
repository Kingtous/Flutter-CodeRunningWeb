import 'package:code_running_front/business/user/models/response/resp_get_threads_entity.dart';

respGetThreadsEntityFromJson(RespGetThreadsEntity data,
    Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<RespGetThreadsData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new RespGetThreadsData().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> respGetThreadsEntityToJson(RespGetThreadsEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  return data;
}

respGetThreadsDataFromJson(RespGetThreadsData data, Map<String, dynamic> json) {
  if (json['avatar'] != null) {
    data.avatar = json['avatar']?.toString();
  }
  if (json['code_url'] != null) {
    data.codeUrl = json['code_url']?.toString();
  }
  if (json['comment_id'] != null) {
    data.commentId = json['comment_id']?.toInt();
  }
  if (json['create_date'] != null) {
    data.createDate = json['create_date']?.toString();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['subtitle'] != null) {
    data.subtitle = json['subtitle']?.toString();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['user_id'] != null) {
    data.userId = json['user_id']?.toInt();
  }
  if (json['user_like'] != null) {
    data.userLike = json['user_like']?.toInt();
  }
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  return data;
}

Map<String, dynamic> respGetThreadsDataToJson(RespGetThreadsData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['avatar'] = entity.avatar;
  data['code_url'] = entity.codeUrl;
  data['comment_id'] = entity.commentId;
  data['create_date'] = entity.createDate;
  data['id'] = entity.id;
  data['subtitle'] = entity.subtitle;
  data['title'] = entity.title;
  data['user_id'] = entity.userId;
  data['user_like'] = entity.userLike;
  data['username'] = entity.username;
  return data;
}