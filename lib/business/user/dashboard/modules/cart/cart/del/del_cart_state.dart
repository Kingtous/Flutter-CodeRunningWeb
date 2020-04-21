import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DelCartState extends Equatable {
  const DelCartState();
}

class InitialDelCartState extends DelCartState {
  @override
  List<Object> get props => [];
}

class NoDelCartState extends DelCartState {
  final String msg;

  NoDelCartState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InDelCartState extends DelCartState {
  @override
  List<Object> get props => [];
}

class DelCartedState extends DelCartState {
  final RespStatusEntity entity;

  DelCartedState(this.entity);

  @override
  List<Object> get props => [entity];
}
