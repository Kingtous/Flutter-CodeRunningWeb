import 'package:code_running_front/business/user/models/request/req_get_my_bought_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetMyBoughtEvent extends Equatable {
  const GetMyBoughtEvent();
}

class InGetMyBoughtEvent extends GetMyBoughtEvent {
  final ReqGetMyBoughtEntity entity;

  InGetMyBoughtEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
