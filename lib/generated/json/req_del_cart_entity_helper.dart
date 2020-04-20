import 'package:code_running_front/business/user/models/request/req_del_cart_entity.dart';

reqDelCartEntityFromJson(ReqDelCartEntity data, Map<String, dynamic> json) {
  if (json['item_id'] != null) {
    data.itemId = json['item_id']?.toInt();
  }
  return data;
}

Map<String, dynamic> reqDelCartEntityToJson(ReqDelCartEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['item_id'] = entity.itemId;
  return data;
}