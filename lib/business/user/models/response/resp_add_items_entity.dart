import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class RespAddItemsEntity with JsonConvert<RespAddItemsEntity> {
  int code;
  RespAddItemsData data;
}

class RespAddItemsData with JsonConvert<RespAddItemsData> {
  int id;
}
