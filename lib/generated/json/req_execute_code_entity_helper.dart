import 'package:code_running_front/business/user/models/request/req_execute_code_entity.dart';

reqExecuteCodeEntityFromJson(ReqExecuteCodeEntity data,
    Map<String, dynamic> json) {
  if (json['url'] != null) {
    data.url = json['url']?.toString();
  }
  return data;
}

Map<String, dynamic> reqExecuteCodeEntityToJson(ReqExecuteCodeEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['url'] = entity.url;
  return data;
}