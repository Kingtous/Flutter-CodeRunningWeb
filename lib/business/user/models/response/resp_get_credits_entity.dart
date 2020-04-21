import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class RespGetCreditsEntity with JsonConvert<RespGetCreditsEntity> {
  int code;
  RespGetCreditsData data;
}

class RespGetCreditsData with JsonConvert<RespGetCreditsData> {
  int credits;
}
