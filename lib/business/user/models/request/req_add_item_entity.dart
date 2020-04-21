import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class ReqAddItemEntity with JsonConvert<ReqAddItemEntity> {
  String name;
  String detail;
  int credits;
  bool isOn;
  String img;
}
