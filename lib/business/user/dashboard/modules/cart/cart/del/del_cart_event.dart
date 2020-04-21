import 'package:code_running_front/business/user/models/request/req_del_cart_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DelCartEvent extends Equatable {
  const DelCartEvent();
}

class InDelCartEvent extends DelCartEvent {
  final ReqDelCartEntity entity;

  InDelCartEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
