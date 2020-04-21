import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class RespGetMallItemsEntity with JsonConvert<RespGetMallItemsEntity> {
  int code;
  List<RespGetMallItemsData> data;
}

class RespGetMallItemsData with JsonConvert<RespGetMallItemsData> {
  int credits;
  String detail;
  int id;
  String img;
  String name;
}
