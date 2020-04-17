import 'package:code_running_front/business/user/models/response/resp_get_codes_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetCodesState extends Equatable {
  const GetCodesState();
}

class NoGetCodesState extends GetCodesState {
  final String msg;

  NoGetCodesState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InGetCodesState extends GetCodesState {
  @override
  List<Object> get props => [];
}

class GetCodesedState extends GetCodesState {
  final RespGetCodesEntity entity;

  GetCodesedState(this.entity);

  @override
  List<Object> get props => [entity];
}
