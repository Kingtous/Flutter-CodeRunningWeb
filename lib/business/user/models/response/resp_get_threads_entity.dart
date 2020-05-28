import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:code_running_front/generated/json/base/json_filed.dart';

class RespGetThreadsEntity with JsonConvert<RespGetThreadsEntity> {
  int code;
  List<RespGetThreadsData> data;
}

class RespGetThreadsData with JsonConvert<RespGetThreadsData> {
	String avatar;
	@JSONField(name: "code_url")
	String codeUrl;
	@JSONField(name: "comment_id")
	int commentId;
	@JSONField(name: "create_date")
	String createDate;
	int id;
	String subtitle;
	String title;
	@JSONField(name: "user_id")
	int userId;
	@JSONField(name: "user_like")
	int userLike;
	String username;
}
