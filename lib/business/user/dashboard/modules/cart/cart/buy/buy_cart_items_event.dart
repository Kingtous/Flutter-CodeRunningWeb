import 'package:code_running_front/business/user/models/request/req_buy_cart_items_entity.dart';
import 'package:equatable/equatable.dart';

abstract class BuyCartItemsEvent extends Equatable {
  const BuyCartItemsEvent();
}

class InBuyCartItemsEvent extends BuyCartItemsEvent {
  final ReqBuyCartItemsEntity entity;

  InBuyCartItemsEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
