import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class ReqResetPasswordEntity with JsonConvert<ReqResetPasswordEntity> {
  String code;
  @JSONField(name: "new_password")
  String newPassword;
}
