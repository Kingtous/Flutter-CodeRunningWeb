import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class ReqThreadCommentEntity with JsonConvert<ReqThreadCommentEntity> {
  @JSONField(name: "thread_id")
  int threadId;
  String content;
}
