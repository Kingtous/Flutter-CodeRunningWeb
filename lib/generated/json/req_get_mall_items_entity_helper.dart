import 'package:code_running_front/business/user/models/request/req_get_mall_items_entity.dart';

reqGetMallItemsEntityFromJson(
    ReqGetMallItemsEntity data, Map<String, dynamic> json) {
  if (json['page'] != null) {
    data.page = json['page']?.toInt();
  }
  return data;
}

Map<String, dynamic> reqGetMallItemsEntityToJson(ReqGetMallItemsEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['page'] = entity.page;
  return data;
}