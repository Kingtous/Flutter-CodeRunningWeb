import 'package:code_running_front/business/user/models/response/resp_execute_code_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ExecuteCodeState extends Equatable {
  const ExecuteCodeState();
}

class InitialExecuteCodeState extends ExecuteCodeState {
  @override
  List<Object> get props => [];
}

class NoExecuteCodeState extends ExecuteCodeState {
  final String msg;
  final bool isError;

  NoExecuteCodeState(this.isError, {this.msg});

  @override
  List<Object> get props => [msg, isError];
}

class InExecuteCodeState extends ExecuteCodeState {
  @override
  List<Object> get props => [];
}

class ExecuteCodeedState extends ExecuteCodeState {
  final RespExecuteCodeEntity entity;

  ExecuteCodeedState(this.entity);

  @override
  List<Object> get props => [entity];
}
