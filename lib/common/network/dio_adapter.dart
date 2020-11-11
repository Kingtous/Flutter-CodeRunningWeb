import 'dart:async';
import 'dart:io';

import 'package:code_running_front/common/utils/toast_utils.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:dio/dio.dart' hide Lock;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart';

import 'http_utils.dart';

class DioAdapter implements HAdapter {
  Dio _dio;
  static final lock = Lock();

  DioAdapter() {
    _dio = new Dio();
  }

  @override
  Future<Response<dynamic>> request(RequestCtx ctx) async {
    Future<Response<dynamic>> response;

    _dio.options = new BaseOptions(
        connectTimeout: ctx.timeout == null ? HConstants.timeout : ctx.timeout,
        receiveTimeout: ctx.timeout == null ? HConstants.timeout : ctx.timeout,
        headers: ctx.headerMap == null ? {} : ctx.headerMap,
        contentType: ctx.contentType == null
            ? ContentType.json.toString()
            : ctx.contentType.toString(),
        responseType:
            ctx.responseType == null ? ResponseType.plain : ctx.responseType,
        validateStatus: (status) {
          return status >= 200 && status < 300 || status == 304;
        });

    if (ctx.transformer != null) {
      _dio.transformer = ctx.transformer;
    }

    if (ctx.interceptors != null && ctx.interceptors.isNotEmpty) {
      for (var value in ctx.interceptors) {
        _dio.interceptors.add(value);
      }
    }

    String url = HttpUtils.get().wrapUrlByParams(ctx.url, ctx.paramMap);
    debugPrint("query:$url");
    debugPrint("body:${ctx.bodyMap.toString()}");

    switch (ctx.method) {
      case "get":
        response = _dio.get(url);
        break;
      case "post":
        response = _dio.post(url, data: ctx.bodyMap);
        break;
      default:
        response = _dio.get(url);
    }
    try {
      var resp = await response;
      var data;
      if (ctx.parser != null) {
        data = ctx.parser.parse(resp.data);
        resp.data = data;
        if (resp.data.code == 1000) {
          await removeUserData();
          Get.offNamedUntil(Routes.indexPage, (route) => false);
        }
      }
      if (ctx.callback != null) {
        ctx.callback(HState.success, data);
      }
      return resp;
    } catch (e) {
      if (e is DioError) {
        if (e.response.statusCode == 401) {
          await lock.synchronized(() async {
            if (getUserInfo() != null) {
              ToastUtils.show("登录过期，请重新登录");
              await removeUserData();
              Get.offNamedUntil(Routes.indexPage, (route) => false);
            }
          });
        }
      }
      if (ctx.callback != null) {
        ctx.callback(HState.fail, e);
      }

      return null;
    }
  }
}
