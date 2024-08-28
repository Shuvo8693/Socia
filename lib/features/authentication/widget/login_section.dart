import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/core/widgets/button/common_button.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_event.dart';

class LogInSection extends StatelessWidget {
  const LogInSection({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTEC,
    required TextEditingController passwordTEC,
    required this.isFieldHeight,
  })  : _formKey = formKey,
        _emailTEC = emailTEC,
        _passwordTEC = passwordTEC;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTEC;
  final TextEditingController _passwordTEC;
  final Function(bool) isFieldHeight;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<AuthBloc>().add(AuthLoginEvent(
                email: _emailTEC.text,
                password: _passwordTEC.text,
                context: context));
          } else {
            return isFieldHeight(true);
          }
        },
        text: 'Log in');
  }
}