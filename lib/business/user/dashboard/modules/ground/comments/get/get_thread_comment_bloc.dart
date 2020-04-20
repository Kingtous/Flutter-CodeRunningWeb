import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_get_thread_comment_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';
import 'package:code_running_front/generated/json/resp_get_thread_comment_entity_helper.dart';

import './bloc.dart';

class GetThreadCommentBloc
    extends Bloc<GetThreadCommentEvent, GetThreadCommentState> {
  @override
  GetThreadCommentState get initialState => InitialGetThreadCommentState();

  @override
  Stream<GetThreadCommentState> mapEventToState(
    GetThreadCommentEvent event,
  ) async* {
    yield* mapInGetThreadCommentEvent(event);
  }

  Stream<GetThreadCommentState> mapInGetThreadCommentEvent(
      InGetThreadCommentEvent event) async* {
    var currentState = state;
    RespGetThreadCommentEntity nEntity;
    if (currentState is GetThreadCommentedState) {
      nEntity = respGetThreadCommentEntityFromJson(
          RespGetThreadCommentEntity(), currentState.entity.toJson());
    }
    yield InGetThreadCommentState();
    var callback = await ApiRequest.getThreadComment(event.entity);
    if (callback != null && callback.data != null) {
      RespGetThreadCommentEntity entity = callback.data;
      if (entity.code == 0) {
        if (event.entity.page != 0 && nEntity != null) {
          nEntity.data.addAll(entity.data);
          yield GetThreadCommentedState(nEntity);
        } else {
          yield GetThreadCommentedState(entity);
        }
      } else {
        yield NoGetThreadCommentState(getErrMsg(entity.code));
      }
    } else {
      yield NoGetThreadCommentState("网络错误");
    }
  }
}
