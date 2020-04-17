import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class RespUploadCodeEntity with JsonConvert<RespUploadCodeEntity> {
  int code;
  RespUploadCodeData data;
}

class RespUploadCodeData with JsonConvert<RespUploadCodeData> {
  int id;
  String url;
}
