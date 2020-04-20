import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class PostThreadBloc extends Bloc<PostThreadEvent, PostThreadState> {
  @override
  PostThreadState get initialState => InitialPostThreadState();

  @override
  Stream<PostThreadState> mapEventToState(
    PostThreadEvent event,
  ) async* {
    yield* mapInPostThreadEvent(event);
  }

  Stream<PostThreadState> mapInPostThreadEvent(InPostThreadEvent event) async* {
    yield InPostThreadState();
    var callback = await ApiRequest.postThread(event.entity);
    if (callback != null && callback.data != null) {
      RespStatusEntity entity = callback.data;
      if (entity.code == 0) {
        yield PostThreadedState(entity);
      } else {
        yield NoPostThreadState(getErrMsg(entity.code));
      }
    } else {
      yield NoPostThreadState("网络错误");
    }
  }
}
