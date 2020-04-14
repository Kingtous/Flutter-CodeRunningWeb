import 'dart:convert';

import 'package:code_running_front/common/network/http_utils.dart';
import 'package:code_running_front/generated/json/base/json_convert_content.dart';
import 'package:flutter/material.dart';

class GeneralJsonParser<T> extends JsonParser<T> {
  JsonConvert<T> jsonConvert;

  GeneralJsonParser(JsonConvert<T> t) {
    this.jsonConvert = t;
  }

  @override
  T parse(String jsonStr) {
    debugPrint(">>>" + jsonStr);
    Map<String, dynamic> p = Map<String, dynamic>.from(json.decode(jsonStr));
    // 这里特判code，保证code一定为int
    if (p['code'] != null) {
      p['code'] = int.parse(p['code']?.toString());
    }
    if (jsonConvert != null) {
      return jsonConvert.fromJson(p);
    } else {
      return null;
    }
  }
}
