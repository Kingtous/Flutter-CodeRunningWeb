import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AddCartState extends Equatable {
  const AddCartState();
}

class InitialAddCartState extends AddCartState {
  @override
  List<Object> get props => [];
}

class NoAddCartState extends AddCartState {
  final String msg;

  NoAddCartState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InAddCartState extends AddCartState {
  @override
  List<Object> get props => [];
}

class AddCartedState extends AddCartState {
  final RespStatusEntity entity;

  AddCartedState(this.entity);

  @override
  List<Object> get props => [entity];
}
