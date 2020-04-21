import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class ReqRegisterEntity with JsonConvert<ReqRegisterEntity> {
	String username;
	String password;
	String code;
	String mail;
}
