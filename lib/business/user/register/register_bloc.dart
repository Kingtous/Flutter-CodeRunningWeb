import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_register_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => NoRegisterState("");

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is InRegisterEvent) {
      yield* mapInRegisterEvent(event);
    }
  }

  Stream<RegisterState> mapInRegisterEvent(InRegisterEvent event) async* {
    yield InRegisterState();
    var callback = await ApiRequest.register(event.entity);
    if (callback != null && callback.data != null) {
      RespRegisterEntity entity = callback.data;
      if (entity.code == 0) {
        yield RegisteredState(entity);
      } else {
        yield NoRegisterState(getErrMsg(entity.code));
      }
    } else {
      yield NoRegisterState("网络错误");
    }
  }
}
