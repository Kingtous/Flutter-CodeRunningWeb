import 'package:code_running_front/business/user/models/response/resp_get_code_result_entity.dart';

respGetCodeResultEntityFromJson(RespGetCodeResultEntity data,
    Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new RespGetCodeResultData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> respGetCodeResultEntityToJson(
    RespGetCodeResultEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

respGetCodeResultDataFromJson(RespGetCodeResultData data,
    Map<String, dynamic> json) {
  if (json['result'] != null) {
    data.result = json['result']?.toString();
  }
  if (json['status'] != null) {
    data.status = json['status']?.toInt();
  }
  return data;
}

Map<String, dynamic> respGetCodeResultDataToJson(RespGetCodeResultData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['result'] = entity.result;
  data['status'] = entity.status;
  return data;
}