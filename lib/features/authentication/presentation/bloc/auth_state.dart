import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitializeState extends AuthState {}

class AuthLoadingState extends AuthState {
  final bool loadingBar;

  AuthLoadingState(this.loadingBar);
}

class AuthenticatedState extends AuthState {}

class AuthUnauthorisedState extends AuthState {}

class AuthFailureState extends AuthState {
  final String failureMessage;
  final bool loadingBar;

  AuthFailureState(this.failureMessage, this.loadingBar);

  @override
  List<Object?> get props => [failureMessage];
}
