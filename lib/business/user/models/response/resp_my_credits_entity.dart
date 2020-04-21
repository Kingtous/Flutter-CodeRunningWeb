import 'package:code_running_front/generated/json/base/json_convert_content.dart';

class RespMyCreditsEntity with JsonConvert<RespMyCreditsEntity> {
  int code;
  RespMyCreditsData data;
}

class RespMyCreditsData with JsonConvert<RespMyCreditsData> {
  int credits;
}
