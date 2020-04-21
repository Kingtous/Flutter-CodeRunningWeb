import 'package:code_running_front/business/user/models/response/resp_get_mall_items_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetMallItemsState extends Equatable {
  const GetMallItemsState();
}

class InitialGetMallItemsState extends GetMallItemsState {
  @override
  List<Object> get props => [];
}

class NoGetMallItemsState extends GetMallItemsState {
  final String msg;

  NoGetMallItemsState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InGetMallItemsState extends GetMallItemsState {
  @override
  List<Object> get props => [];
}

class GetMallItemsedState extends GetMallItemsState {
  final RespGetMallItemsEntity entity;

  GetMallItemsedState(this.entity);

  @override
  List<Object> get props => [entity];
}
