import 'package:code_running_front/business/user/models/request/req_upload_code_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UploadCodeEvent extends Equatable {
  const UploadCodeEvent();
}

class InUploadCodeEvent extends UploadCodeEvent {
  final ReqUploadCodeEntity entity;

  InUploadCodeEvent(this.entity);

  @override
  List<Object> get props => [entity];
}
