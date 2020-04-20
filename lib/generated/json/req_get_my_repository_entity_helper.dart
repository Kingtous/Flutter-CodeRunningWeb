import 'package:code_running_front/business/user/models/request/req_get_my_repository_entity.dart';

reqGetMyRepositoryEntityFromJson(ReqGetMyRepositoryEntity data,
    Map<String, dynamic> json) {
  if (json['page'] != null) {
    data.page = json['page']?.toInt();
  }
  return data;
}

Map<String, dynamic> reqGetMyRepositoryEntityToJson(
    ReqGetMyRepositoryEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['page'] = entity.page;
  return data;
}