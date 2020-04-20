import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class RespGetMyRepositoryEntity with JsonConvert<RespGetMyRepositoryEntity> {
  int code;
  List<RespGetMyRepositoryData> data;
}

class RespGetMyRepositoryData with JsonConvert<RespGetMyRepositoryData> {
  int credits;
  String detail;
  int id;
  bool isOn;
  String name;
}
