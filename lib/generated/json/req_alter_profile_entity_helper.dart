import 'package:code_running_front/business/user/models/request/req_alter_profile_entity.dart';

reqAlterProfileEntityFromJson(
    ReqAlterProfileEntity data, Map<String, dynamic> json) {
  if (json['field'] != null) {
    data.field = json['field']?.toString();
  }
  if (json['value'] != null) {
    data.value = json['value']?.toString();
  }
  return data;
}

Map<String, dynamic> reqAlterProfileEntityToJson(ReqAlterProfileEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['field'] = entity.field;
  data['value'] = entity.value;
  return data;
}
