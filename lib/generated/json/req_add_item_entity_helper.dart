import 'package:code_running_front/business/user/models/request/req_add_item_entity.dart';

reqAddItemEntityFromJson(ReqAddItemEntity data, Map<String, dynamic> json) {
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['detail'] != null) {
    data.detail = json['detail']?.toString();
  }
  if (json['credits'] != null) {
    data.credits = json['credits']?.toInt();
  }
  if (json['isOn'] != null) {
    data.isOn = json['isOn'];
  }
  if (json['img'] != null) {
    data.img = json['img']?.toString();
  }
  return data;
}

Map<String, dynamic> reqAddItemEntityToJson(ReqAddItemEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = entity.name;
  data['detail'] = entity.detail;
  data['credits'] = entity.credits;
  data['isOn'] = entity.isOn;
  data['img'] = entity.img;
  return data;
}