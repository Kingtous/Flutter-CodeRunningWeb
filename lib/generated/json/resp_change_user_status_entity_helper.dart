import 'package:code_running_front/business/user/models/response/resp_change_user_status_entity.dart';

respChangeUserStatusEntityFromJson(
    RespChangeUserStatusEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = json['data'];
  }
  return data;
}

Map<String, dynamic> respChangeUserStatusEntityToJson(
    RespChangeUserStatusEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['data'] = entity.data;
  return data;
}
