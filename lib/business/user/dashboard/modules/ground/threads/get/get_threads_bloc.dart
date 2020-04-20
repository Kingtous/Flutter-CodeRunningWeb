import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_get_threads_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';
import 'package:code_running_front/generated/json/resp_get_threads_entity_helper.dart';

import 'bloc.dart';

class GetThreadsBloc extends Bloc<GetThreadsEvent, GetThreadsState> {
  @override
  GetThreadsState get initialState => InitialGetThreadsState();

  @override
  Stream<GetThreadsState> mapEventToState(
    GetThreadsEvent event,
  ) async* {
    yield* mapInGetThreadsEvent(event);
  }

  Stream<GetThreadsState> mapInGetThreadsEvent(InGetThreadsEvent event) async* {
    RespGetThreadsEntity nEntity;
    if (state is GetThreadsedState) {
      GetThreadsedState o = state;
      nEntity = respGetThreadsEntityFromJson(
          RespGetThreadsEntity(), o.entity.toJson());
    }
    yield InGetThreadsState();
    var callback = await ApiRequest.getThreads(event.entity);
    if (callback != null && callback.data != null) {
      RespGetThreadsEntity entity = callback.data;
      if (entity.code == 0) {
        if (nEntity != null && event.entity.page != 1) {
          nEntity.data.addAll(entity.data);
          yield GetThreadsedState(nEntity);
        } else
          yield GetThreadsedState(entity);
      } else {
        yield NoGetThreadsState(getErrMsg(entity.code));
      }
    } else {
      yield NoGetThreadsState("网络错误");
    }
  }
}
