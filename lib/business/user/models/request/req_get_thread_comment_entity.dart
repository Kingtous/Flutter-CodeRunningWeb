import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class ReqGetThreadCommentEntity with JsonConvert<ReqGetThreadCommentEntity> {
  @JSONField(name: "thread_id")
  int threadId;
  int page;
}
