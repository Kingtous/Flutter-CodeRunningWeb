import 'package:code_running_front/business/user/models/request/req_post_thread_entity.dart';

reqPostThreadEntityFromJson(
    ReqPostThreadEntity data, Map<String, dynamic> json) {
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['subtitle'] != null) {
    data.subtitle = json['subtitle']?.toString();
  }
  return data;
}

Map<String, dynamic> reqPostThreadEntityToJson(ReqPostThreadEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['title'] = entity.title;
  data['subtitle'] = entity.subtitle;
  return data;
}