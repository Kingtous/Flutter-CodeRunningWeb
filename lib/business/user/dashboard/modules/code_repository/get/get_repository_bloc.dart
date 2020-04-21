import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_get_repository_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';
import 'package:code_running_front/generated/json/resp_get_repository_entity_helper.dart';
import 'package:flutter/material.dart';

import './bloc.dart';

class GetRepositoryBloc extends Bloc<GetRepositoryEvent, GetRepositoryState> {
  @override
  GetRepositoryState get initialState => InitialGetRepositoryState();

  @override
  Stream<GetRepositoryState> mapEventToState(
    GetRepositoryEvent event,
  ) async* {
    yield* mapInGetRepositoryEvent(event);
  }

  Stream<GetRepositoryState> mapInGetRepositoryEvent(
      InGetRepositoryEvent event) async* {
    var currentState = state;
    var e;
    if (currentState is GetRepositoryedState) {
      e = currentState.entity;
    }

    debugPrint("请求的offset:${event.entity.offset}");
    yield InGetRepositoryState();
    var callback = await ApiRequest.getRepository(event.entity);
    if (callback != null && callback.data != null) {
      RespGetRepositoryEntity entity = callback.data;
      if (entity.code == 0) {
        if (e == null) {
          yield GetRepositoryedState(entity);
        } else {
          RespGetRepositoryEntity newEntity = respGetRepositoryEntityFromJson(
              RespGetRepositoryEntity(), e.toJson());
          newEntity.data.addAll(entity.data);
          yield GetRepositoryedState(newEntity);
        }
      } else {
        yield NoGetRepositoryState(getErrMsg(entity.code));
      }
    } else {
      yield NoGetRepositoryState("网络错误");
    }
  }
}
