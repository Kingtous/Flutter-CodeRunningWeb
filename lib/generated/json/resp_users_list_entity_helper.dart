import 'package:code_running_front/business/user/models/response/resp_users_list_entity.dart';

respUsersListEntityFromJson(
    RespUsersListEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<RespUsersListData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new RespUsersListData().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> respUsersListEntityToJson(RespUsersListEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  return data;
}

respUsersListDataFromJson(RespUsersListData data, Map<String, dynamic> json) {
  if (json['avatar_url'] != null) {
    data.avatarUrl = json['avatar_url']?.toString();
  }
  if (json['enable'] != null) {
    data.enable = json['enable'];
  }
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['nickname'] != null) {
    data.nickname = json['nickname']?.toString();
  }
  if (json['role'] != null) {
    data.role = json['role']?.toInt();
  }
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  return data;
}

Map<String, dynamic> respUsersListDataToJson(RespUsersListData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['avatar_url'] = entity.avatarUrl;
  data['enable'] = entity.enable;
  data['id'] = entity.id;
  data['nickname'] = entity.nickname;
  data['role'] = entity.role;
  data['username'] = entity.username;
  return data;
}
