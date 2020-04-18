import 'package:code_running_front/business/user/models/response/resp_execute_code_entity.dart';

respExecuteCodeEntityFromJson(
    RespExecuteCodeEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new RespExecuteCodeData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> respExecuteCodeEntityToJson(RespExecuteCodeEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

respExecuteCodeDataFromJson(
    RespExecuteCodeData data, Map<String, dynamic> json) {
  if (json['code_id'] != null) {
    data.codeId = json['code_id']?.toInt();
  }
  return data;
}

Map<String, dynamic> respExecuteCodeDataToJson(RespExecuteCodeData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code_id'] = entity.codeId;
  return data;
}
