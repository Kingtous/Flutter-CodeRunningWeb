import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_status_event.dart';

part 'request_status_state.dart';

class RequestStatusBloc extends Bloc<RequestStatusEvent, RequestStatusState> {
  @override
  RequestStatusState get initialState => RequestStatusInitial();

  @override
  Stream<RequestStatusState> mapEventToState(
    RequestStatusEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
