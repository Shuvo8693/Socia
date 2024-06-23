import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socia/features/profile/data/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthStartedEvent extends AuthEvent {}

class AuthRegisteredEvent extends AuthEvent {
  final String email;
  final String password;
  final UserList userModel;
  final BuildContext context;

  AuthRegisteredEvent(this.context,
      {required this.email, required this.password, required this.userModel});
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  AuthLoginEvent(
      {required this.email, required this.password, required this.context});
}

class AuthLoggedOutEvent extends AuthEvent {}
