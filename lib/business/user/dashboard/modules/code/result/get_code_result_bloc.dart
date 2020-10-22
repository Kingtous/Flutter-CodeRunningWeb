import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_get_code_result_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class GetCodeResultBloc extends Bloc<GetCodeResultEvent, GetCodeResultState> {
  @override
  GetCodeResultState get initialState => InitialGetCodeResultState();

  @override
  Stream<GetCodeResultState> mapEventToState(
    GetCodeResultEvent event,
  ) async* {
    if (event is GetCodeResultEvent) {
      yield* mapInGetCodeResultEvent(event);
    }
  }

  Stream<GetCodeResultState> mapInGetCodeResultEvent(
      InGetCodeResultEvent event) async* {
    yield InGetCodeResultState();
    while (true) {
      var callback = await ApiRequest.getCodeResult(event.entity);
      if (callback != null && callback.data != null) {
        RespGetCodeResultEntity entity = callback.data;
        if (entity.code == 0) {
          yield GetCodeResultedState(entity);
          if (entity.data.status > 2) {
            // status >2 表示服务器已经处理完请求
            break;
          } else {
            await Future.delayed(Duration(seconds: 1), () {});
          }
        } else {
          yield NoGetCodeResultState(true, msg: getErrMsg(entity.code));
        }
      } else {
        yield NoGetCodeResultState(true, msg: "网络错误");
      }
    }
  }
}
