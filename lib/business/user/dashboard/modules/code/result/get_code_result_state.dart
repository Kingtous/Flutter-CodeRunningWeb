import 'package:code_running_front/business/user/models/response/resp_get_code_result_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetCodeResultState extends Equatable {
  const GetCodeResultState();
}

class InitialGetCodeResultState extends GetCodeResultState {
  @override
  List<Object> get props => [];
}

class NoGetCodeResultState extends GetCodeResultState {
  final String msg;
  final bool isError;

  NoGetCodeResultState(this.isError, {this.msg});

  @override
  List<Object> get props => [msg];
}

class InGetCodeResultState extends GetCodeResultState {
  @override
  List<Object> get props => [];
}

class GetCodeResultedState extends GetCodeResultState {
  final RespGetCodeResultEntity entity;

  GetCodeResultedState(this.entity);

  @override
  List<Object> get props => [entity];
}
