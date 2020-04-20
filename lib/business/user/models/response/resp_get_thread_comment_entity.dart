import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespGetThreadCommentEntity with JsonConvert<RespGetThreadCommentEntity> {
  int code;
  List<RespGetThreadCommentData> data;
}

class RespGetThreadCommentData with JsonConvert<RespGetThreadCommentData> {
  @JSONField(name: "code_url")
  String codeUrl;
  String content;
  @JSONField(name: "create_date")
  double createDate;
  int id;
  @JSONField(name: "next_id")
  dynamic nextId;
  @JSONField(name: "parent_id")
  int parentId;
  @JSONField(name: "threads_id")
  int threadsId;
  @JSONField(name: "user_id")
  int userId;
  String username;
}
