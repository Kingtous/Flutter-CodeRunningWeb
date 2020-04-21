import 'package:code_running_front/business/user/models/request/req_get_my_cart_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetMyCartEvent extends Equatable {
  const GetMyCartEvent();
}

class InGetMyCartEvent extends GetMyCartEvent {
  final ReqGetMyCartEntity entity;

  InGetMyCartEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
