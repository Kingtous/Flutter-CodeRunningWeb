import 'package:code_running_front/business/user/models/request/req_execute_code_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ExecuteCodeEvent extends Equatable {
  const ExecuteCodeEvent();
}

class InExecuteCodeEvent extends ExecuteCodeEvent {
  final ReqExecuteCodeEntity entity;

  InExecuteCodeEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
