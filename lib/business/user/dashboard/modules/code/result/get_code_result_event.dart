import 'package:equatable/equatable.dart';

abstract class GetCodeResultEvent extends Equatable {
  const GetCodeResultEvent();
}

class InGetCodeResultEvent extends GetCodeResultEvent {
  final ReqGetCodeResultEntity entity;

  InGetCodeResultEvent(this.entity);

  @override
  List<Object> get props => [entity];
}

class ReqGetCodeResultEntity {
  final int codeId;

  ReqGetCodeResultEntity(this.codeId);
}
