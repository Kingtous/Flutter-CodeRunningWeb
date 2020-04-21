import 'package:code_running_front/business/user/models/request/req_get_credits_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetCreditsEvent extends Equatable {
  const GetCreditsEvent();
}

class InGetCreditsEvent extends GetCreditsEvent {
  final ReqGetCreditsEntity entity;

  InGetCreditsEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
