import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespGetMyBoughtEntity with JsonConvert<RespGetMyBoughtEntity> {
  int code;
  List<RespGetMyBoughtData> data;
}

class RespGetMyBoughtData with JsonConvert<RespGetMyBoughtData> {
  int credits;
  String detail;
  int id;
  String img;
  bool isOn;
  String name;
  @JSONField(name: "repo_id")
  int repoId;
}
