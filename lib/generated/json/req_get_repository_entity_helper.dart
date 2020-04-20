import 'package:code_running_front/business/user/models/request/req_get_repository_entity.dart';

reqGetRepositoryEntityFromJson(ReqGetRepositoryEntity data,
    Map<String, dynamic> json) {
  if (json['offset'] != null) {
    data.offset = json['offset']?.toInt();
  }
  return data;
}

Map<String, dynamic> reqGetRepositoryEntityToJson(
    ReqGetRepositoryEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['offset'] = entity.offset;
  return data;
}