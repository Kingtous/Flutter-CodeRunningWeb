import 'package:code_running_front/business/user/models/response/resp_login_entity.dart';

respLoginEntityFromJson(RespLoginEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new RespLoginData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> respLoginEntityToJson(RespLoginEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

respLoginDataFromJson(RespLoginData data, Map<String, dynamic> json) {
  if (json['avatar_url'] != null) {
    data.avatarUrl = json['avatar_url']?.toString();
  }
  if (json['credits'] != null) {
    data.credits = json['credits']?.toInt();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['nickname'] != null) {
    data.nickname = json['nickname']?.toString();
  }
  if (json['token'] != null) {
    data.token = json['token']?.toString();
  }
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  return data;
}

Map<String, dynamic> respLoginDataToJson(RespLoginData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['avatar_url'] = entity.avatarUrl;
  data['credits'] = entity.credits;
  data['id'] = entity.id;
  data['nickname'] = entity.nickname;
  data['token'] = entity.token;
  data['username'] = entity.username;
  return data;
}
