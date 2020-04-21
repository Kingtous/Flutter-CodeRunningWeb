import 'package:code_running_front/business/user/models/request/req_get_profile_entity.dart';

reqGetProfileEntityFromJson(
    ReqGetProfileEntity data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  return data;
}

Map<String, dynamic> reqGetProfileEntityToJson(ReqGetProfileEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  return data;
}
