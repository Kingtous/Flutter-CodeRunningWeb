import 'package:code_running_front/business/user/models/response/resp_get_my_bought_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetMyBoughtState extends Equatable {
  const GetMyBoughtState();
}

class InitialGetMyBoughtState extends GetMyBoughtState {
  @override
  List<Object> get props => [];
}

class NoGetMyBoughtState extends GetMyBoughtState {
  final String msg;

  NoGetMyBoughtState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InGetMyBoughtState extends GetMyBoughtState {
  @override
  List<Object> get props => [];
}

class GetMyBoughtedState extends GetMyBoughtState {
  final RespGetMyBoughtEntity entity;

  GetMyBoughtedState(this.entity);

  @override
  List<Object> get props => [entity];
}
