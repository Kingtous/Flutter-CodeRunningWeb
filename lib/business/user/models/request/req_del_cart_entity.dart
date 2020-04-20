import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class ReqDelCartEntity with JsonConvert<ReqDelCartEntity> {
  @JSONField(name: "item_id")
  int itemId;
}
