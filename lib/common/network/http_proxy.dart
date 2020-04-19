import 'dart:convert';

import 'package:code_running_front/business/user/dashboard/modules/code/result/get_code_result_event.dart';
import 'package:code_running_front/business/user/models/request/req_execute_code_entity.dart';
import 'package:code_running_front/business/user/models/request/req_login_entity.dart';
import 'package:code_running_front/business/user/models/request/req_register_entity.dart';
import 'package:code_running_front/business/user/models/request/req_upload_code_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_execute_code_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_code_result_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_login_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_register_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_upload_code_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_utils.dart';
import 'package:code_running_front/utils/general_json_parser.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiRequest {
  static Map<String, dynamic> addBasicAuthHeader(Map<String, dynamic> header) {
    String token = getStoredToken();
    debugPrint("token:$token");
    String basicAuth = "Basic " + base64Encode(utf8.encode('$token:'));
    header["Authorization"] = basicAuth;
    debugPrint("header:${header.toString()}");
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

  /// 代码上传
  static Future<Response> uploadCode(ReqUploadCodeEntity entity) async {
    return await HttpUtils.get().req(uploadApi,
    header: addBasicAuthHeader(Map()),
        method: HConstants.post,
        body: entity.toJson(),
        parser: GeneralJsonParser(RespUploadCodeEntity()));
  }

  /// 获取代码结果
  static getCodeResult(ReqGetCodeResultEntity entity) async {
    return await HttpUtils.get().req(getCodeResultApi,
    header: addBasicAuthHeader(Map()),
        method: HConstants.get,
        parser: GeneralJsonParser(RespGetCodeResultEntity()),
        params: {"code_id": entity.codeId});
  }

  /// 执行代码
  static executeCode(ReqExecuteCodeEntity entity) async {
    return await HttpUtils.get().req(runApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.post,
        parser: GeneralJsonParser(RespExecuteCodeEntity()),
        body: entity.toJson());
  }
}
