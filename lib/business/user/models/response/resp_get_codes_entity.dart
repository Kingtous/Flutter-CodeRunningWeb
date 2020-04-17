import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespGetCodesEntity with JsonConvert<RespGetCodesEntity> {
  int code;
  List<RespGetCodesData> data;
}

class RespGetCodesData with JsonConvert<RespGetCodesData> {
  @JSONField(name: "code_type")
  int codeType;
  @JSONField(name: "create_date")
  int createDate;
  int id;
  @JSONField(name: "local_path")
  String localPath;
}
