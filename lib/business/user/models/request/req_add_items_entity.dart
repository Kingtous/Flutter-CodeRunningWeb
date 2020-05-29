import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class ReqAddItemsEntity with JsonConvert<ReqAddItemsEntity> {
  int id;
  String name;
  String detail;
  int credits;
  bool isOn;
  String img;
}
