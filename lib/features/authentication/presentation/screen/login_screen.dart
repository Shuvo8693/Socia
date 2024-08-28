import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/widgets/button/back_button_svg.dart';
import 'package:socia/core/widgets/form_text_field.dart';
import 'package:socia/core/widgets/spacing/spacing.dart';
import 'package:socia/features/authentication/data/service/auth_login_service.dart';
import 'package:socia/features/authentication/data/service/auth_register_service.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_state.dart';
import 'package:socia/features/authentication/widget/activity_indicator.dart';
import 'package:socia/features/authentication/widget/check_box.dart';
import 'package:socia/features/authentication/widget/login_section.dart';
import 'package:socia/features/authentication/widget/register_section.dart';
import 'package:socia/features/authentication/widget/validator.dart';
import 'package:socia/injection_container.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key, required this.isLogin});

  final bool isLogin;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _check = false;
  bool _obscureText = true;
  bool _activityBar = false;
  bool _isTextFieldHeight = false;

  void _toggleChecked() {
    setState(() {
      _check = !_check;
    });
  }

  void _toggleObscured() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final AuthBloc _authBloc = AuthBloc(
      authRegisterService: di<AuthRegisterService>(),
      authLogInService: di<AuthLogInService>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonSvg(),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 295.rW,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Your Email & Password',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      verticalSpace(20.rH),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Email', textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      FormTextField(
                        boxHeight: _isTextFieldHeight ? 80.rH : 50.rH,
                        controller: _emailTEC,
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Input email',
                        suffixIcon: null,
                        obscureText: false,
                        validator: emailValidator,
                      ),
                      verticalSpace(10.rH),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.rH),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Password', textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      FormTextField(
                        boxHeight: _isTextFieldHeight ? 95.rH : 50.rH,
                        controller: _passwordTEC,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        hintText: 'Input password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _toggleObscured();
                          },
                          icon: _obscureText
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                        ),
                        obscureText: _obscureText,
                        validator: passWordValidator,
                      ),
                      verticalSpace(1.rH),
                      widget.isLogin
                          ? verticalSpace(10.rH)
                          : CheckBox(
                              check: _check,
                              onPressed: () {
                                _toggleChecked();
                              },
                            ),
                      verticalSpace(16.rH),
                      BlocProvider(
                        create: (context) => _authBloc,
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoadingState) {
                              _buildLoading(state) ;
                            } else if (state is AuthFailureState) {
                              _buildAuthFailureLoading(state);
                            }
                            return widget.isLogin
                                ? LogInSection(
                                    formKey: _formKey,
                                    emailTEC: _emailTEC,
                                    passwordTEC: _passwordTEC,
                                    isFieldHeight: (bool value) {
                                      setState(() {
                                        _isTextFieldHeight = value;
                                      });
                                    },
                                  )
                                : RegisterSection(
                                    formKey: _formKey,
                                    emailTEC: _emailTEC,
                                    passwordTEC: _passwordTEC,
                                    isFieldHeight: (bool value) {
                                      setState(() {
                                        _isTextFieldHeight = value;
                                      });
                                    },
                                  );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          _activityBar
              ? const ActivityIndicatorContainer()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  _buildLoading(AuthLoadingState state) {
    return WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _activityBar = state.loadingBar;
        setState(() {});
      }
    });
  }

  _buildAuthFailureLoading(AuthFailureState state) {
    return WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (mounted) {
          _activityBar = state.loadingBar;
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
  }
}
