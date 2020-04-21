import 'package:code_running_front/business/user/models/response/resp_get_credits_entity.dart';

respGetCreditsEntityFromJson(
    RespGetCreditsEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new RespGetCreditsData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> respGetCreditsEntityToJson(RespGetCreditsEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

respGetCreditsDataFromJson(RespGetCreditsData data, Map<String, dynamic> json) {
  if (json['credits'] != null) {
    data.credits = json['credits']?.toInt();
  }
  return data;
}

Map<String, dynamic> respGetCreditsDataToJson(RespGetCreditsData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['credits'] = entity.credits;
  return data;
}
