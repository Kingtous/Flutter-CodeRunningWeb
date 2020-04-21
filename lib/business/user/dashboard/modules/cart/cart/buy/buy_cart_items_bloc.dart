import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_buy_cart_items_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import 'bloc.dart';

class BuyCartItemsBloc extends Bloc<BuyCartItemsEvent, BuyCartItemsState> {
  @override
  BuyCartItemsState get initialState => InitialBuyCartItemsState();

  @override
  Stream<BuyCartItemsState> mapEventToState(
    BuyCartItemsEvent event,
  ) async* {
    yield* mapInBuyCartItemsEvent(event);
  }

  Stream<BuyCartItemsState> mapInBuyCartItemsEvent(
      InBuyCartItemsEvent event) async* {
    yield InBuyCartItemsState();
    var callback = await ApiRequest.buyCartItems(event.entity);
    if (callback != null && callback.data != null) {
      RespBuyCartItemsEntity entity = callback.data;
      if (entity.code == 0) {
        yield BuyCartItemsedState(entity);
      } else {
        yield NoBuyCartItemsState(getErrMsg(entity.code));
      }
    } else {
      yield NoBuyCartItemsState("网络错误");
    }
  }
}
