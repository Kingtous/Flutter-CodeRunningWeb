import 'package:code_running_front/business/user/models/request/req_get_threads_entity.dart';

reqGetThreadsEntityFromJson(
    ReqGetThreadsEntity data, Map<String, dynamic> json) {
  if (json['page'] != null) {
    data.page = json['page']?.toInt();
  }
  return data;
}

Map<String, dynamic> reqGetThreadsEntityToJson(ReqGetThreadsEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['page'] = entity.page;
  return data;
}
