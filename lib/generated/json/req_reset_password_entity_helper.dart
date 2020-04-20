import 'package:code_running_front/business/user/models/request/req_reset_password_entity.dart';

reqResetPasswordEntityFromJson(ReqResetPasswordEntity data,
    Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toString();
  }
  if (json['new_password'] != null) {
    data.newPassword = json['new_password']?.toString();
  }
  return data;
}

Map<String, dynamic> reqResetPasswordEntityToJson(
    ReqResetPasswordEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['new_password'] = entity.newPassword;
  return data;
}