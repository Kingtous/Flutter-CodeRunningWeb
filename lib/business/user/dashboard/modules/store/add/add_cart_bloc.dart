import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import 'bloc.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  @override
  AddCartState get initialState => InitialAddCartState();

  @override
  Stream<AddCartState> mapEventToState(
    AddCartEvent event,
  ) async* {
    yield* mapInAddCartEvent(event);
  }

  Stream<AddCartState> mapInAddCartEvent(InAddCartEvent event) async* {
    yield InAddCartState();
    var callback = await ApiRequest.addCart(event.entity);
    if (callback != null && callback.data != null) {
      RespStatusEntity entity = callback.data;
      if (entity.code == 0) {
        yield AddCartedState(entity);
      } else {
        yield NoAddCartState(getErrMsg(entity.code));
      }
    } else {
      yield NoAddCartState("网络错误");
    }
  }
}
