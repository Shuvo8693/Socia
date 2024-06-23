import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/core/widgets/BottomNavBarScreen.dart';
import 'package:socia/features/authentication/data/service/auth_login_service.dart';
import 'package:socia/features/authentication/data/service/auth_service.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_event.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_state.dart';

import '../../../../core/widgets/snacbar.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authService, required this.authLogInService})
      : super(AuthInitializeState()) {
    on<AuthRegisteredEvent>(
        (event, emit) async => await onAuthRegister(event, emit));
    on<AuthLoginEvent>((event, emit) => onAuthLogIn(event, emit));
  }

  AuthService authService;
  AuthLogInService authLogInService;

  onAuthRegister(event, emit) async {
    try {
      if (event is AuthRegisteredEvent) {
        emit(AuthLoadingState(true));
        await authService
            .createCredentials(event.email, event.password, event.userModel)
            .then((value) {
          if (value) {
            Navigator.push(event.context,
                MaterialPageRoute(builder: (context) => BottomNavBarScreen()));
          } else {
            emit(AuthLoadingState(false));
            emit(AuthFailureState(authService.existMessage, false));
            snackBarMessage(
                context: event.context,
                title: authService.existMessage,
                isColorRed: true);
          }
        }).onError((error, stackTrace) {
          log('AuthFailed:$error');
          emit(AuthFailureState(error.toString(), false));
          snackBarMessage(
              context: event.context,
              title: error.toString(),
              isColorRed: true);
        });
      }
    } catch (e) {
      log('AuthCatch:$e');
      emit(AuthFailureState(e.toString(), false));
      snackBarMessage(
          context: event.context, title: e.toString(), isColorRed: true);
    }
  }

  onAuthLogIn(event, emit) async {
    if (event is AuthLoginEvent) {
      emit(AuthLoadingState(true));
      await authLogInService
          .requestToLogIn(event.email, event.password)
          .then((value) {
        if (value) {
          Navigator.push(event.context,
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()));
        } else {
          emit(AuthFailureState(authLogInService.errorMessage, false));
          snackBarMessage(
              context: event.context,
              title: authLogInService.errorMessage,
              isColorRed: true);
        }
      }).onError((error, stackTrace) {
        emit(AuthFailureState(error.toString(), false));
        snackBarMessage(
            context: event.context, title: error.toString(), isColorRed: true);
      });
    }
  }
}
