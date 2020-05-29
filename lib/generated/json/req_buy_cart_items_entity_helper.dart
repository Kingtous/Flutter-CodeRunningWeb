import 'package:code_running_front/business/user/models/request/req_buy_cart_items_entity.dart';

reqBuyCartItemsEntityFromJson(ReqBuyCartItemsEntity data,
    Map<String, dynamic> json) {
  if (json['ids'] != null) {
    data.ids = json['ids']?.map((v) => v?.toInt())?.toList()?.cast<int>();
  }
  return data;
}

Map<String, dynamic> reqBuyCartItemsEntityToJson(ReqBuyCartItemsEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ids'] = entity.ids;
  return data;
}