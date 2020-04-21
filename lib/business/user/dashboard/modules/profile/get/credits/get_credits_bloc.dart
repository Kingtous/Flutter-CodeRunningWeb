import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_running_front/business/user/models/response/resp_get_credits_entity.dart';
import 'package:code_running_front/common/network/http_constants.dart';
import 'package:code_running_front/common/network/http_proxy.dart';

import './bloc.dart';

class GetCreditsBloc extends Bloc<GetCreditsEvent, GetCreditsState> {
  @override
  GetCreditsState get initialState => InitialGetCreditsState();

  @override
  Stream<GetCreditsState> mapEventToState(
    GetCreditsEvent event,
  ) async* {
    yield* mapInGetCreditsEvent(event);
  }

  Stream<GetCreditsState> mapInGetCreditsEvent(InGetCreditsEvent event) async* {
    yield InGetCreditsState();
    var callback = await ApiRequest.getCredits(event.entity);
    if (callback != null && callback.data != null) {
      RespGetCreditsEntity entity = callback.data;
      if (entity.code == 0) {
        yield GetCreditsedState(entity);
      } else {
        yield NoGetCreditsState(getErrMsg(entity.code));
      }
    } else {
      yield NoGetCreditsState("网络错误");
    }
  }
}
