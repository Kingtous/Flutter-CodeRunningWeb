import 'package:code_running_front/business/user/models/response/resp_get_my_cart_entity.dart';

respGetMyCartEntityFromJson(RespGetMyCartEntity data,
    Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<RespGetMyCartData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new RespGetMyCartData().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> respGetMyCartEntityToJson(RespGetMyCartEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  return data;
}

respGetMyCartDataFromJson(RespGetMyCartData data, Map<String, dynamic> json) {
  if (json['credits'] != null) {
    data.credits = json['credits']?.toInt();
  }
  if (json['detail'] != null) {
    data.detail = json['detail']?.toString();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['isOn'] != null) {
    data.isOn = json['isOn'];
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  return data;
}

Map<String, dynamic> respGetMyCartDataToJson(RespGetMyCartData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['credits'] = entity.credits;
  data['detail'] = entity.detail;
  data['id'] = entity.id;
  data['isOn'] = entity.isOn;
  data['name'] = entity.name;
  return data;
}