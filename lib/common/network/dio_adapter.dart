import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'http_utils.dart';

class DioAdapter implements HAdapter {
  Dio _dio;

  DioAdapter() {
    _dio = new Dio();
  }

  @override
  Future<Response<dynamic>> request(RequestCtx ctx) async {
    Future<Response<dynamic>> response;

    _dio.options = new BaseOptions(
        connectTimeout: ctx.timeout == null ? HConstants.timeout : ctx.timeout,
        receiveTimeout: ctx.timeout == null ? HConstants.timeout : ctx.timeout,
        headers: ctx.headerMap == null
            ? {}
            : ctx.headerMap,
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
      }
      if (ctx.callback != null) {
        ctx.callback(HState.success, data);
      }
      return resp;
    } catch (e) {
      if (ctx.callback != null) {
        ctx.callback(HState.fail, e);
      }
      return null;
    }
  }
}
