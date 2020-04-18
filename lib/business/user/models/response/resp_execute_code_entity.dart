import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespExecuteCodeEntity with JsonConvert<RespExecuteCodeEntity> {
  int code;
  RespExecuteCodeData data;
}

class RespExecuteCodeData with JsonConvert<RespExecuteCodeData> {
  @JSONField(name: "code_id")
  int codeId;
}
