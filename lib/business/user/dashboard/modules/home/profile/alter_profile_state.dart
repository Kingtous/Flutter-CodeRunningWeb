import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AlterProfileState extends Equatable {
  const AlterProfileState();
}

class InitialAlterProfileState extends AlterProfileState {
  @override
  List<Object> get props => [];
}

class NoAlterProfileState extends AlterProfileState {
  final String msg;

  NoAlterProfileState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InAlterProfileState extends AlterProfileState {
  @override
  List<Object> get props => [];
}

class AlterProfileedState extends AlterProfileState {
  final RespStatusEntity entity;

  AlterProfileedState(this.entity);

  @override
  List<Object> get props => [entity];
}
