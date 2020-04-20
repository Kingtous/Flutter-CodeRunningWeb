import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class RespGetMyCartEntity with JsonConvert<RespGetMyCartEntity> {
  int code;
  List<RespGetMyCartData> data;
}

class RespGetMyCartData with JsonConvert<RespGetMyCartData> {
  int credits;
  String detail;
  int id;
  bool isOn;
  String name;
}
