part of 'login_status_bloc.dart';

abstract class LoginStatusState extends Equatable {
  const LoginStatusState();
}

class LoginStatusInitial extends LoginStatusState {
  @override
  List<Object> get props => [];
}

class NotLoginState extends LoginStatusState {
  @override
  List<Object> get props => [];
}

class LoginedState extends LoginStatusState {
  @override
  List<Object> get props => [];
}
