import 'package:code_running_front/business/user/models/response/resp_get_my_bought_entity.dart';

respGetMyBoughtEntityFromJson(
    RespGetMyBoughtEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new List<RespGetMyBoughtData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new RespGetMyBoughtData().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> respGetMyBoughtEntityToJson(RespGetMyBoughtEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  return data;
}

respGetMyBoughtDataFromJson(RespGetMyBoughtData data,
    Map<String, dynamic> json) {
  if (json['credits'] != null) {
    data.credits = json['credits']?.toInt();
  }
  if (json['detail'] != null) {
    data.detail = json['detail']?.toString();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['img'] != null) {
    data.img = json['img']?.toString();
  }
  if (json['isOn'] != null) {
    data.isOn = json['isOn'];
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['repo_id'] != null) {
    data.repoId = json['repo_id']?.toInt();
  }
  return data;
}

Map<String, dynamic> respGetMyBoughtDataToJson(RespGetMyBoughtData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['credits'] = entity.credits;
  data['detail'] = entity.detail;
  data['id'] = entity.id;
  data['img'] = entity.img;
  data['isOn'] = entity.isOn;
  data['name'] = entity.name;
  data['repo_id'] = entity.repoId;
  return data;
}