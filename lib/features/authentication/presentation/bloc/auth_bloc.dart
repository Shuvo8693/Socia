import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/core/routing/router.dart';
import 'package:socia/core/widgets/snacbar.dart';
import 'package:socia/features/authentication/data/service/auth_login_service.dart';
import 'package:socia/features/authentication/data/service/auth_register_service.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_event.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_state.dart';



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRegisterService authRegisterService;
  AuthLogInService authLogInService;

  AuthBloc({required this.authRegisterService, required this.authLogInService})
      : super(AuthInitializeState()) {
    on<AuthRegisteredEvent>(
        (event, emit) async => await onAuthRegister(event, emit));
    on<AuthLoginEvent>((event, emit) => onAuthLogIn(event, emit));
  }

  onAuthRegister(event, emit) async {
    if (event is AuthRegisteredEvent) {
      emit(AuthLoadingState(true));
      await authRegisterService
          .createCredentials(event.email, event.password, event.userModel)
          .then(
        (value) {
          if (value.success && value.user?.email != null) {
            emit(AuthLoadingState(false));
            Routers.pushReplacementNamed(routeName: Routers.baseScreen);
          } else {
            emit(AuthLoadingState(false));
            emit(AuthFailureState(value.errorMessage!, false));
            snackBarMessage(
                context: event.context,
                title: value.errorMessage!,
                isColorRed: true);
          }
        },
      ).onError(
        (error, stackTrace) {
          log('AuthFailed:$error');
          emit(AuthLoadingState(false));
          emit(AuthFailureState(error.toString(), false));
          snackBarMessage(
              context: event.context,
              title: error.toString(),
              isColorRed: true);
        },
      );
    }
  }

  onAuthLogIn(event, emit) async {
    emit(AuthLoadingState(true));
    if (event is AuthLoginEvent) {
      await authLogInService.requestToLogIn(event.email, event.password).then(
        (value) {
          if (value.success) {
            emit(AuthLoadingState(false));
            Routers.pushReplacementNamed(routeName: Routers.baseScreen);
          } else {
            emit(AuthLoadingState(false));
            emit(AuthFailureState(value.errorMessage!, false));
            snackBarMessage(
                context: event.context,
                title: value.errorMessage!,
                isColorRed: true);
          }
        },
      ).onError(
        (error, stackTrace) {
          emit(AuthFailureState(error.toString(), false));
          emit(AuthLoadingState(false));
          snackBarMessage(
              context: event.context,
              title: error.toString(),
              isColorRed: true);
        },
      );
    }
  }
}
