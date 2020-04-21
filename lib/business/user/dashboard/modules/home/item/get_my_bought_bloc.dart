import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_get_my_bought_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class GetMyBoughtBloc extends Bloc<GetMyBoughtEvent, GetMyBoughtState> {
  @override
  GetMyBoughtState get initialState => InitialGetMyBoughtState();

  @override
  Stream<GetMyBoughtState> mapEventToState(
    GetMyBoughtEvent event,
  ) async* {
    yield* mapInGetMyBoughtEvent(event);
  }

  Stream<GetMyBoughtState> mapInGetMyBoughtEvent(
      InGetMyBoughtEvent event) async* {
    yield InGetMyBoughtState();
    var callback = await ApiRequest.getMyBought(event.entity);
    if (callback != null && callback.data != null) {
      RespGetMyBoughtEntity entity = callback.data;
      if (entity.code == 0) {
        yield GetMyBoughtedState(entity);
      } else {
        yield NoGetMyBoughtState(getErrMsg(entity.code));
      }
    } else {
      yield NoGetMyBoughtState("网络错误");
    }
  }
}
