import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/core/widgets/button/common_button.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_event.dart';
import 'package:socia/features/profile/data/models/user_model.dart';

class RegisterSection extends StatelessWidget {
  const RegisterSection({
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
            context.read<AuthBloc>().add(
                  AuthRegisteredEvent(
                    context,
                    email: _emailTEC.text,
                    password: _passwordTEC.text,
                    userModel: UserItem(
                      bio: '',
                      displayName: '',
                      email: _emailTEC.text,
                      profilePictureURL: '',
                      userName: '',
                      follower: [],
                      following: [],
                      createdAt: Timestamp.now(),
                      updatedAt: Timestamp.now(),
                    ),
                  ),
                );
          } else {
             return isFieldHeight(true);
          }
        },
        text: 'Register');
  }
}
