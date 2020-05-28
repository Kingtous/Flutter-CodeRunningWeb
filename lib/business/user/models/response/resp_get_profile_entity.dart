import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespGetProfileEntity with JsonConvert<RespGetProfileEntity> {
  int code;
  RespGetProfileData data;
}

class RespGetProfileData with JsonConvert<RespGetProfileData> {
	@JSONField(name: "avatar_url")
	String avatarUrl;
	int id;
	String nickname;
	int role;
	String username;
}
