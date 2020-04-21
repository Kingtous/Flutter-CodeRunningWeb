import 'package:code_running_front/business/user/models/request/req_get_mall_items_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetMallItemsEvent extends Equatable {
  const GetMallItemsEvent();
}

class InGetMallItemsEvent extends GetMallItemsEvent {
  final ReqGetMallItemsEntity entity;

  InGetMallItemsEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
