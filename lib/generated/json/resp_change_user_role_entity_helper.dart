import 'package:code_running_front/business/user/models/response/resp_change_user_role_entity.dart';

respChangeUserRoleEntityFromJson(
    RespChangeUserRoleEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = json['data']?.toInt();
  }
  return data;
}

Map<String, dynamic> respChangeUserRoleEntityToJson(
    RespChangeUserRoleEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['data'] = entity.data;
  return data;
}
