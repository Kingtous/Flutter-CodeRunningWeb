import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_get_profile_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  @override
  GetProfileState get initialState => InitialGetProfileState();

  @override
  Stream<GetProfileState> mapEventToState(
    GetProfileEvent event,
  ) async* {
    yield* mapInGetProfileEvent(event);
  }

  Stream<GetProfileState> mapInGetProfileEvent(InGetProfileEvent event) async* {
    yield InGetProfileState();
    var callback = await ApiRequest.getProfile(event.entity);
    if (callback != null && callback.data != null) {
      RespGetProfileEntity entity = callback.data;
      if (entity.code == 0) {
        yield GetProfileedState(entity);
      } else {
        yield NoGetProfileState(getErrMsg(entity.code));
      }
    } else {
      yield NoGetProfileState("网络错误");
    }
  }
}
