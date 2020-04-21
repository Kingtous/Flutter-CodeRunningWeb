import 'package:code_running_front/business/user/models/response/resp_get_profile_entity.dart';

respGetProfileEntityFromJson(
    RespGetProfileEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new RespGetProfileData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> respGetProfileEntityToJson(RespGetProfileEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

respGetProfileDataFromJson(RespGetProfileData data, Map<String, dynamic> json) {
  if (json['avatar_url'] != null) {
    data.avatarUrl = json['avatar_url']?.toString();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['nickname'] != null) {
    data.nickname = json['nickname']?.toString();
  }
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  return data;
}

Map<String, dynamic> respGetProfileDataToJson(RespGetProfileData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['avatar_url'] = entity.avatarUrl;
  data['id'] = entity.id;
  data['nickname'] = entity.nickname;
  data['username'] = entity.username;
  return data;
}
