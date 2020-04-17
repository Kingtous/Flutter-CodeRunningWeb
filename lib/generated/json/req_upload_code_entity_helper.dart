import 'package:code_running_front/business/user/models/request/req_upload_code_entity.dart';

reqUploadCodeEntityFromJson(
    ReqUploadCodeEntity data, Map<String, dynamic> json) {
  if (json['content'] != null) {
    data.content = json['content']?.toString();
  }
  if (json['fileName'] != null) {
    data.fileName = json['fileName']?.toString();
  }
  return data;
}

Map<String, dynamic> reqUploadCodeEntityToJson(ReqUploadCodeEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['content'] = entity.content;
  data['fileName'] = entity.fileName;
  return data;
}
