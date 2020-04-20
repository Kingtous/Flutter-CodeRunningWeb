import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';

respStatusEntityFromJson(RespStatusEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  return data;
}

Map<String, dynamic> respStatusEntityToJson(RespStatusEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  return data;
}