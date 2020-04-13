part of 'request_status_bloc.dart';

abstract class RequestStatusState extends Equatable {
  const RequestStatusState();
}

class RequestStatusInitial extends RequestStatusState {
  @override
  List<Object> get props => [];
}
