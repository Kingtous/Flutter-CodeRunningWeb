import 'package:code_running_front/business/user/models/response/resp_upload_code_entity.dart';

respUploadCodeEntityFromJson(
    RespUploadCodeEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new RespUploadCodeData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> respUploadCodeEntityToJson(RespUploadCodeEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

respUploadCodeDataFromJson(RespUploadCodeData data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['url'] != null) {
    data.url = json['url']?.toString();
  }
  return data;
}

Map<String, dynamic> respUploadCodeDataToJson(RespUploadCodeData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['url'] = entity.url;
  return data;
}