import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_get_my_cart_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class GetMyCartBloc extends Bloc<GetMyCartEvent, GetMyCartState> {
  @override
  GetMyCartState get initialState => InitialGetMyCartState();

  @override
  Stream<GetMyCartState> mapEventToState(
    GetMyCartEvent event,
  ) async* {
    yield* mapInGetMyCartEvent(event);
  }

  Stream<GetMyCartState> mapInGetMyCartEvent(InGetMyCartEvent event) async* {
    yield InGetMyCartState();
    var callback = await ApiRequest.getMyCart(event.entity);
    if (callback != null && callback.data != null) {
      RespGetMyCartEntity entity = callback.data;
      if (entity.code == 0) {
        yield GetMyCartedState(entity);
      } else {
        yield NoGetMyCartState(getErrMsg(entity.code));
      }
    } else {
      yield NoGetMyCartState("网络错误");
    }
  }
}
