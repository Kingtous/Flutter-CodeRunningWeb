import 'package:code_running_front/business/user/models/response/resp_get_my_cart_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetMyCartState extends Equatable {
  const GetMyCartState();
}

class InitialGetMyCartState extends GetMyCartState {
  @override
  List<Object> get props => [];
}

class NoGetMyCartState extends GetMyCartState {
  final String msg;

  NoGetMyCartState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InGetMyCartState extends GetMyCartState {
  @override
  List<Object> get props => [];
}

class GetMyCartedState extends GetMyCartState {
  final RespGetMyCartEntity entity;

  GetMyCartedState(this.entity);

  @override
  List<Object> get props => [entity];
}
