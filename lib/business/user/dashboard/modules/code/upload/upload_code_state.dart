import 'package:code_running_front/business/user/models/response/resp_upload_code_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UploadCodeState extends Equatable {
  const UploadCodeState();
}

class NoUploadCodeState extends UploadCodeState {
  final String msg;

  NoUploadCodeState(this.msg);

  @override
  List<Object> get props => [msg];
}

class InUploadCodeState extends UploadCodeState {
  @override
  List<Object> get props => [];
}

class UploadCodeedState extends UploadCodeState {
  final RespUploadCodeEntity entity;

  UploadCodeedState(this.entity);

  @override
  List<Object> get props => [entity];
}
