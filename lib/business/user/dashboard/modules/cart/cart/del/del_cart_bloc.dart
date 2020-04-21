import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import 'bloc.dart';

class DelCartBloc extends Bloc<DelCartEvent, DelCartState> {
  @override
  DelCartState get initialState => InitialDelCartState();

  @override
  Stream<DelCartState> mapEventToState(
    DelCartEvent event,
  ) async* {
    yield* mapInDelCartEvent(event);
  }

  Stream<DelCartState> mapInDelCartEvent(InDelCartEvent event) async* {
    yield InDelCartState();
    var callback = await ApiRequest.delCart(event.entity);
    if (callback != null && callback.data != null) {
      RespStatusEntity entity = callback.data;
      if (entity.code == 0) {
        yield DelCartedState(entity);
      } else {
        yield NoDelCartState(getErrMsg(entity.code));
      }
    } else {
      yield NoDelCartState("网络错误");
    }
  }
}
