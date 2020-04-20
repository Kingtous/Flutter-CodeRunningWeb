import 'dart:convert';

import 'package:code_running_front/business/user/dashboard/modules/code/result/get_code_result_event.dart';
import 'package:code_running_front/business/user/models/request/req_add_cart_entity.dart';
import 'package:code_running_front/business/user/models/request/req_del_cart_entity.dart';
import 'package:code_running_front/business/user/models/request/req_execute_code_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_mall_items_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_my_cart_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_my_repository_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_repository_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_thread_comment_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_threads_entity.dart';
import 'package:code_running_front/business/user/models/request/req_login_entity.dart';
import 'package:code_running_front/business/user/models/request/req_post_thread_entity.dart';
import 'package:code_running_front/business/user/models/request/req_register_entity.dart';
import 'package:code_running_front/business/user/models/request/req_thread_comment_entity.dart';
import 'package:code_running_front/business/user/models/request/req_upload_code_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_execute_code_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_code_result_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_mall_items_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_my_cart_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_my_repository_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_repository_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_thread_comment_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_threads_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_login_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_register_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
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

  /// 获取自己的代码仓库
  static getRepository(ReqGetRepositoryEntity entity) async {
    return await HttpUtils.get().req(
      '$getSelfCodesApi${entity.offset}',
      header: addBasicAuthHeader(Map()),
      method: HConstants.get,
      parser: GeneralJsonParser(RespGetRepositoryEntity()),
    );
  }

  /// 获取热门帖子
  static getThreads(ReqGetThreadsEntity entity) async {
    return await HttpUtils.get().req(getThreadsApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.get,
        parser: GeneralJsonParser(
          RespGetThreadsEntity(),
        ),
        params: entity.toJson());
  }

  /// 获取评论
  static getThreadComment(ReqGetThreadCommentEntity entity) async {
    return await HttpUtils.get().req(getThreadCommentsApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.get,
        parser: GeneralJsonParser(
          RespGetThreadCommentEntity(),
        ),
        params: entity.toJson());
  }

  /// 发表评论
  static postThreadComment(ReqThreadCommentEntity entity) async {
    return await HttpUtils.get().req(postThreadCommentApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.post,
        parser: GeneralJsonParser(
          RespStatusEntity(),
        ),
        body: entity.toJson());
  }

  /// 发布帖子
  static postThread(ReqPostThreadEntity entity) async {
    return await HttpUtils.get().req(postThreadApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.post,
        parser: GeneralJsonParser(
          RespStatusEntity(),
        ),
        body: entity.toJson());
  }

  /// 获取商城商品
  static getMallItems(ReqGetMallItemsEntity entity) async {
    return await HttpUtils.get().req(getMallItemsApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.get,
        parser: GeneralJsonParser(RespGetMallItemsEntity()),
        body: entity.toJson());
  }

  /// 获取购物车
  static getMyCart(ReqGetMyCartEntity entity) async {
    return await HttpUtils.get().req(getMallItemsApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.get,
        parser: GeneralJsonParser(RespGetMyCartEntity()),
        body: entity.toJson());
  }

  /// 获取我的仓库/购买的内容
  static getMyRepository(ReqGetMyRepositoryEntity entity) async {
    return await HttpUtils.get().req(getMallItemsApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.get,
        parser: GeneralJsonParser(RespGetMyRepositoryEntity()),
        body: entity.toJson());
  }

  /// 添加入购物车
  static addCart(ReqAddCartEntity entity) async {
    return await HttpUtils.get().req(getMallItemsApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.post,
        parser: GeneralJsonParser(RespStatusEntity()),
        body: entity.toJson());
  }

  /// 添加入购物车
  static delCart(ReqDelCartEntity entity) async {
    return await HttpUtils.get().req(getMallItemsApi,
        header: addBasicAuthHeader(Map()),
        method: HConstants.post,
        parser: GeneralJsonParser(RespStatusEntity()),
        body: entity.toJson());
  }
}
