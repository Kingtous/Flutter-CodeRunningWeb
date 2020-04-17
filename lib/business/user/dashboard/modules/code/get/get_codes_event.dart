import 'package:equatable/equatable.dart';

abstract class GetCodesEvent extends Equatable {
  const GetCodesEvent();
}

class InGetCodesEvent extends GetCodesEvent {
  final ReqGetCodesEntity entity;

  InGetCodesEvent(this.entity);

  @override
  List<Object> get props => [entity];
}

class ReqGetCodesEntity {
  final int page;

  ReqGetCodesEntity(this.page);
}
