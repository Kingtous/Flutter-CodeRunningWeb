import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  @override
  ResetPasswordState get initialState => InitialResetPasswordState();

  @override
  Stream<ResetPasswordState> mapEventToState(
    ResetPasswordEvent event,
  ) async* {
    yield* mapInResetPasswordEvent(event);
  }

  Stream<ResetPasswordState> mapInResetPasswordEvent(
      InResetPasswordEvent event) async* {
    yield InResetPasswordState();
    var callback = await ApiRequest.resetPassword(event.entity);
    if (callback != null && callback.data != null) {
      RespStatusEntity entity = callback.data;
      if (entity.code == 0) {
        yield ResetPasswordedState(entity);
      } else {
        yield NoResetPasswordState(getErrMsg(entity.code));
      }
    } else {
      yield NoResetPasswordState("网络错误");
    }
  }
}
