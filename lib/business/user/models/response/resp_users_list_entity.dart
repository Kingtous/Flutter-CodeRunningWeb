import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespUsersListEntity with JsonConvert<RespUsersListEntity> {
  int code;
  List<RespUsersListData> data;
}

class RespUsersListData with JsonConvert<RespUsersListData> {
  @JSONField(name: "avatar_url")
  String avatarUrl;
  bool enable;
  int id;
  String nickname;
  int role;
  String username;
}
