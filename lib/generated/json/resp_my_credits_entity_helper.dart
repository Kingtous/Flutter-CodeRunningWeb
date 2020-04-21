import 'package:code_running_front/business/user/models/response/resp_my_credits_entity.dart';

respMyCreditsEntityFromJson(
    RespMyCreditsEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new RespMyCreditsData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> respMyCreditsEntityToJson(RespMyCreditsEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

respMyCreditsDataFromJson(RespMyCreditsData data, Map<String, dynamic> json) {
  if (json['credits'] != null) {
    data.credits = json['credits']?.toInt();
  }
  return data;
}

Map<String, dynamic> respMyCreditsDataToJson(RespMyCreditsData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['credits'] = entity.credits;
  return data;
}
