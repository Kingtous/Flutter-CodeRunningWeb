import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_upload_code_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class UploadCodeBloc extends Bloc<UploadCodeEvent, UploadCodeState> {
  @override
  UploadCodeState get initialState => NoUploadCodeState("");

  @override
  Stream<UploadCodeState> mapEventToState(
    UploadCodeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case InUploadCodeEvent:
        yield* mapInUploadCodeEvent(event);
        break;
    }
  }

  Stream<UploadCodeState> mapInUploadCodeEvent(InUploadCodeEvent event) async* {
    yield InUploadCodeState();
    var callback = await ApiRequest.uploadCode(event.entity);
    if (callback != null && callback.data != null) {
      RespUploadCodeEntity entity = callback.data;
      if (entity.code == 0) {
        yield UploadCodeedState(entity);
      } else {
        yield NoUploadCodeState(getErrMsg(entity.code));
      }
    } else {
      yield NoUploadCodeState("网络错误");
    }
  }
}
