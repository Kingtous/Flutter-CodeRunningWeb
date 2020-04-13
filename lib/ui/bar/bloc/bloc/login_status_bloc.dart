import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_status_event.dart';

part 'login_status_state.dart';

class LoginStatusBloc extends Bloc<LoginStatusEvent, LoginStatusState> {
  @override
  LoginStatusState get initialState => LoginStatusInitial();

  @override
  Stream<LoginStatusState> mapEventToState(
    LoginStatusEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
