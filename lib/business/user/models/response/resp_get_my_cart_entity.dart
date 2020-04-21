import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespGetMyCartEntity with JsonConvert<RespGetMyCartEntity> {
  int code;
  List<RespGetMyCartData> data;
}

class RespGetMyCartData with JsonConvert<RespGetMyCartData> {
  @JSONField(name: "cart_item_id")
  int cartItemId;
  int credits;
  String detail;
  int id;
  String img;
  bool isOn;
  String name;
}
