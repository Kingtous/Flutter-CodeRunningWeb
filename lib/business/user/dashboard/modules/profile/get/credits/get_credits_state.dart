import 'package:code_running_front/business/user/models/response/resp_get_credits_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetCreditsState extends Equatable {
  const GetCreditsState();
}

class InitialGetCreditsState extends GetCreditsState {
  @override
  List<Object> get props => [];
}

class NoGetCreditsState extends GetCreditsState {
  final String msg;

  NoGetCreditsState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InGetCreditsState extends GetCreditsState {
  @override
  List<Object> get props => [];
}

class GetCreditsedState extends GetCreditsState {
  final RespGetCreditsEntity entity;

  GetCreditsedState(this.entity);

  @override
  List<Object> get props => [entity];
}
