import 'dart:convert';

import 'package:code_running_front/business/user/models/request/req_login_entity.dart';
import 'package:code_running_front/business/user/models/request/req_register_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_login_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_register_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_utils.dart';
import 'package:code_running_front/utils/general_json_parser.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:dio/dio.dart';

class ApiRequest {
  static Map<String, dynamic> addBasicAuthHeader(Map<String, dynamic> header) {
    String token = getStoredToken();
    String basicAuth = "Basic " + base64Encode(utf8.encode('$token:'));
    header["Authorization"] = basicAuth;
    return header;
  }

  static Map<String, dynamic> addJsonContentTypeHeader(
      Map<String, dynamic> header) {
    header["Content-Type"] = "application/json";
    return header;
  }

  /// 登录用户
  static Future<Response> login(ReqLoginEntity entity) async {
    return await HttpUtils.get().req(loginApi,
        method: HConstants.post,
        body: entity.toJson(),
        parser: GeneralJsonParser(RespLoginEntity()));
  }

  /// 注册用户
  static Future<Response> register(ReqRegisterEntity entity) async {
    return await HttpUtils.get().req(registerApi,
        method: HConstants.post,
        body: entity.toJson(),
        parser: GeneralJsonParser(RespRegisterEntity()));
  }
}