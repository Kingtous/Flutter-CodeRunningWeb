import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_get_mall_items_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class GetMallItemsBloc extends Bloc<GetMallItemsEvent, GetMallItemsState> {
  @override
  GetMallItemsState get initialState => InitialGetMallItemsState();

  @override
  Stream<GetMallItemsState> mapEventToState(
    GetMallItemsEvent event,
  ) async* {
    yield* mapInGetMallItemsEvent(event);
  }

  Stream<GetMallItemsState> mapInGetMallItemsEvent(
      InGetMallItemsEvent event) async* {
    yield InGetMallItemsState();
    var callback = await ApiRequest.getMallItems(event.entity);
    if (callback != null && callback.data != null) {
      RespGetMallItemsEntity entity = callback.data;
      if (entity.code == 0) {
        yield GetMallItemsedState(entity);
      } else {
        yield NoGetMallItemsState(getErrMsg(entity.code));
      }
    } else {
      yield NoGetMallItemsState("网络错误");
    }
  }
}
