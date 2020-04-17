import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class GetCodesBloc extends Bloc<GetCodesEvent, GetCodesState> {
  @override
  GetCodesState get initialState => NoGetCodesState("");

  @override
  Stream<GetCodesState> mapEventToState(
    GetCodesEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
