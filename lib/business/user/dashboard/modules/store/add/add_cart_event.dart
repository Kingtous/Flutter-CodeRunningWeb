import 'package:code_running_front/business/user/models/request/req_add_cart_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AddCartEvent extends Equatable {
  const AddCartEvent();
}

class InAddCartEvent extends AddCartEvent {
  final ReqAddCartEntity entity;

  InAddCartEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
