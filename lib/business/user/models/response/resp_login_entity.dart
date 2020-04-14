import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespLoginEntity with JsonConvert<RespLoginEntity> {
  int code;
  RespLoginData data;
}

class RespLoginData with JsonConvert<RespLoginData> {
  @JSONField(name: "avatar_url")
  String avatarUrl;
  int credits;
  int id;
  String nickname;
  String token;
  String username;
}
