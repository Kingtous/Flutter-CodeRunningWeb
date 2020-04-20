import 'package:code_running_front/business/user/models/response/resp_get_repository_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetRepositoryState extends Equatable {
  const GetRepositoryState();
}

class InitialGetRepositoryState extends GetRepositoryState {
  @override
  List<Object> get props => [];
}

class NoGetRepositoryState extends GetRepositoryState {
  final String msg;

  NoGetRepositoryState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InGetRepositoryState extends GetRepositoryState {
  @override
  List<Object> get props => [];
}

class GetRepositoryedState extends GetRepositoryState {
  final RespGetRepositoryEntity entity;

  GetRepositoryedState(this.entity);

  @override
  List<Object> get props => [entity];
}
