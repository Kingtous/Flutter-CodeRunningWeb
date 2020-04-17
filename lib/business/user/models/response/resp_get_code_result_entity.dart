import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class RespGetCodeResultEntity with JsonConvert<RespGetCodeResultEntity> {
  int code;
  RespGetCodeResultData data;
}

class RespGetCodeResultData with JsonConvert<RespGetCodeResultData> {
  String result;
  int status;
}
