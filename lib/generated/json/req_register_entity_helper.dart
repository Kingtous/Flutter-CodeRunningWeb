import 'package:code_running_front/business/user/models/request/req_register_entity.dart';

reqRegisterEntityFromJson(ReqRegisterEntity data, Map<String, dynamic> json) {
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  if (json['password'] != null) {
    data.password = json['password']?.toString();
  }
  if (json['code'] != null) {
    data.code = json['code']?.toString();
  }
  if (json['mail'] != null) {
    data.mail = json['mail']?.toString();
  }
  return data;
}

Map<String, dynamic> reqRegisterEntityToJson(ReqRegisterEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['username'] = entity.username;
  data['password'] = entity.password;
  data['code'] = entity.code;
  data['mail'] = entity.mail;
  return data;
}