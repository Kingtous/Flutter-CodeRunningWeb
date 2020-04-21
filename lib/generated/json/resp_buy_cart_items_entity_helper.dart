import 'package:code_running_front/business/user/models/response/resp_buy_cart_items_entity.dart';

respBuyCartItemsEntityFromJson(
    RespBuyCartItemsEntity data, Map<String, dynamic> json) {
  if (json['code'] != null) {
    data.code = json['code']?.toInt();
  }
  if (json['data'] != null) {
    data.data = json['data']?.toInt();
  }
  return data;
}

Map<String, dynamic> respBuyCartItemsEntityToJson(
    RespBuyCartItemsEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['code'] = entity.code;
  data['data'] = entity.data;
  return data;
}
