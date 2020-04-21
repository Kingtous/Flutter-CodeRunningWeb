import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class SendResetPasswordMailBloc
    extends Bloc<SendResetPasswordMailEvent, SendResetPasswordMailState> {
  @override
  SendResetPasswordMailState get initialState =>
      InitialSendResetPasswordMailState();

  @override
  Stream<SendResetPasswordMailState> mapEventToState(
    SendResetPasswordMailEvent event,
  ) async* {
    yield* mapInSendResetPasswordMailEvent(event);
  }

  Stream<SendResetPasswordMailState> mapInSendResetPasswordMailEvent(
      InSendResetPasswordMailEvent event) async* {
    yield InSendResetPasswordMailState();
    var callback = await ApiRequest.sendResetPasswordMail(event.entity);
    if (callback != null && callback.data != null) {
      RespStatusEntity entity = callback.data;
      if (entity.code == 0) {
        yield SendResetPasswordMailedState(entity);
      } else {
        yield NoSendResetPasswordMailState(getErrMsg(entity.code));
      }
    } else {
      yield NoSendResetPasswordMailState("网络错误");
    }
  }
}
