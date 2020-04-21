import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class SendRegisterEmailBloc
    extends Bloc<SendRegisterEmailEvent, SendRegisterEmailState> {
  @override
  SendRegisterEmailState get initialState => InitialSendRegisterEmailState();

  @override
  Stream<SendRegisterEmailState> mapEventToState(
    SendRegisterEmailEvent event,
  ) async* {
    yield* mapInSendRegisterEmailEvent(event);
  }

  Stream<SendRegisterEmailState> mapInSendRegisterEmailEvent(
      InSendRegisterEmailEvent event) async* {
    yield InSendRegisterEmailState();
    var callback = await ApiRequest.sendRegisterEmail(event.entity);
    if (callback != null && callback.data != null) {
      RespStatusEntity entity = callback.data;
      if (entity.code == 0) {
        yield SendRegisterEmailedState(entity);
      } else {
        yield NoSendRegisterEmailState(getErrMsg(entity.code));
      }
    } else {
      yield NoSendRegisterEmailState("网络错误");
    }
  }
}
