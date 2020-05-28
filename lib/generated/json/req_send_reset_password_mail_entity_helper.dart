import 'package:code_running_front/business/user/models/request/req_send_reset_password_mail_entity.dart';

reqSendResetPasswordMailEntityFromJson(
    ReqSendResetPasswordMailEntity data, Map<String, dynamic> json) {
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  return data;
}

Map<String, dynamic> reqSendResetPasswordMailEntityToJson(
    ReqSendResetPasswordMailEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['username'] = entity.username;
  return data;
}