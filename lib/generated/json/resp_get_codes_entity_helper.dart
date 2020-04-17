import 'package:code_running_front/business/user/models/response/resp_get_codes_entity.dart';

respGetCodesEntityFromJson(RespGetCodesEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<RespGetCodesData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new RespGetCodesData().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> respGetCodesEntityToJson(RespGetCodesEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  return data;
}

respGetCodesDataFromJson(RespGetCodesData data, Map<String, dynamic> json) {
  if (json['code_type'] != null) {
    data.codeType = json['code_type']?.toInt();
  }
  if (json['create_date'] != null) {
    data.createDate = json['create_date']?.toInt();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['local_path'] != null) {
    data.localPath = json['local_path']?.toString();
  }
  return data;
}

Map<String, dynamic> respGetCodesDataToJson(RespGetCodesData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code_type'] = entity.codeType;
  data['create_date'] = entity.createDate;
  data['id'] = entity.id;
  data['local_path'] = entity.localPath;
  return data;
}
