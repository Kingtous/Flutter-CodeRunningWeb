import 'package:code_running_front/business/user/models/response/resp_add_items_entity.dart';

respAddItemsEntityFromJson(RespAddItemsEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = new RespAddItemsData().fromJson(json['data']);
  }
  return data;
}

Map<String, dynamic> respAddItemsEntityToJson(RespAddItemsEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  return data;
}

respAddItemsDataFromJson(RespAddItemsData data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  return data;
}

Map<String, dynamic> respAddItemsDataToJson(RespAddItemsData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  return data;
}
