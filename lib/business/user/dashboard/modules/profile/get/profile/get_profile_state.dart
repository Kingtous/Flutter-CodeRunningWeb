import 'package:code_running_front/business/user/models/response/resp_get_profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();
}

class InitialGetProfileState extends GetProfileState {
  @override
  List<Object> get props => [];
}

class NoGetProfileState extends GetProfileState {
  final String msg;

  NoGetProfileState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InGetProfileState extends GetProfileState {
  @override
  List<Object> get props => [];
}

class GetProfileedState extends GetProfileState {
  final RespGetProfileEntity entity;

  GetProfileedState(this.entity);

  @override
  List<Object> get props => [entity];
}
