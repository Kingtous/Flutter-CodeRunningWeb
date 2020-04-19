import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_execute_code_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';
import 'package:flutter/material.dart';

import './bloc.dart';

class ExecuteCodeBloc extends Bloc<ExecuteCodeEvent, ExecuteCodeState> {
  @override
  ExecuteCodeState get initialState => InitialExecuteCodeState();

  @override
  Stream<ExecuteCodeState> mapEventToState(
    ExecuteCodeEvent event,
  ) async* {
    if (event is InExecuteCodeEvent) {
      debugPrint("exe event got");
      yield* mapInExecuteCodeEvent(event);
    }
  }

  Stream<ExecuteCodeState> mapInExecuteCodeEvent(
      InExecuteCodeEvent event) async* {
    yield InExecuteCodeState();
    var callback = await ApiRequest.executeCode(event.entity);
    debugPrint(callback.toString());
    if (callback != null && callback.data != null) {
      RespExecuteCodeEntity entity = callback.data;
      if (entity.code == 0) {
        yield ExecuteCodeedState(entity);
      } else {
        yield NoExecuteCodeState(true, msg: getErrMsg(entity.code));
      }
    } else {
      yield NoExecuteCodeState(true, msg: "网络错误");
    }
  }
}
