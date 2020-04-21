import 'package:code_running_front/business/user/models/response/resp_buy_cart_items_entity.dart';
import 'package:equatable/equatable.dart';

abstract class BuyCartItemsState extends Equatable {
  const BuyCartItemsState();
}

class InitialBuyCartItemsState extends BuyCartItemsState {
  @override
  List<Object> get props => [];
}

class NoBuyCartItemsState extends BuyCartItemsState {
  final String msg;

  NoBuyCartItemsState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InBuyCartItemsState extends BuyCartItemsState {
  @override
  List<Object> get props => [];
}

class BuyCartItemsedState extends BuyCartItemsState {
  final RespBuyCartItemsEntity entity;

  BuyCartItemsedState(this.entity);

  @override
  List<Object> get props => [entity];
}
