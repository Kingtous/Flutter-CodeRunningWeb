import 'package:code_running_front/business/user/models/request/req_send_register_email_entity.dart';

reqSendRegisterEmailEntityFromJson(
    ReqSendRegisterEmailEntity data, Map<String, dynamic> json) {
  if (json['email'] != null) {
    data.email = json['email']?.toString();
  }
  return data;
}

Map<String, dynamic> reqSendRegisterEmailEntityToJson(
    ReqSendRegisterEmailEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['email'] = entity.email;
  return data;
}