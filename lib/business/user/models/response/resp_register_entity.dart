import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespRegisterEntity with JsonConvert<RespRegisterEntity> {
  int code;
  RespRegisterData data;
}

class RespRegisterData with JsonConvert<RespRegisterData> {
  @JSONField(name: "avatar_url")
  String avatarUrl;
  int credits;
  int id;
  String nickname;
  String token;
  String username;
}
