import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class PostThreadCommentBloc
    extends Bloc<PostThreadCommentEvent, PostThreadCommentState> {
  @override
  PostThreadCommentState get initialState => InitialPostThreadCommentState();

  @override
  Stream<PostThreadCommentState> mapEventToState(
    PostThreadCommentEvent event,
  ) async* {
    yield* mapInPostThreadCommentEvent(event);
  }

  Stream<PostThreadCommentState> mapInPostThreadCommentEvent(
      InPostThreadCommentEvent event) async* {
    yield InPostThreadCommentState();
    var callback = await ApiRequest.postThreadComment(event.entity);
    if (callback != null && callback.data != null) {
      RespStatusEntity entity = callback.data;
      if (entity.code == 0) {
        yield PostThreadCommentedState(entity);
      } else {
        yield NoPostThreadCommentState(getErrMsg(entity.code));
      }
    } else {
      yield NoPostThreadCommentState("网络错误");
    }
  }
}
