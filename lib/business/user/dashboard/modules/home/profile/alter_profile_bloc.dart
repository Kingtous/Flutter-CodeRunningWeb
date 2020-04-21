import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class AlterProfileBloc extends Bloc<AlterProfileEvent, AlterProfileState> {
  @override
  AlterProfileState get initialState => InitialAlterProfileState();

  @override
  Stream<AlterProfileState> mapEventToState(
    AlterProfileEvent event,
  ) async* {
    yield* mapInAlterProfileEvent(event);
  }

  Stream<AlterProfileState> mapInAlterProfileEvent(
      InAlterProfileEvent event) async* {
    yield InAlterProfileState();
    var callback = await ApiRequest.alterProfile(event.entity);
    if (callback != null && callback.data != null) {
      RespStatusEntity entity = callback.data;
      if (entity.code == 0) {
        yield AlterProfileedState(entity);
      } else {
        yield NoAlterProfileState(getErrMsg(entity.code));
      }
    } else {
      yield NoAlterProfileState("网络错误");
    }
  }
}
