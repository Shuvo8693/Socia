import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/config/theme/app_sizes.dart';
import 'package:socia/core/widgets/back_button_svg.dart';
import 'package:socia/core/widgets/common_button.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_state.dart';
import 'package:socia/features/authentication/widget/validator.dart';
import 'package:socia/features/profile/data/models/user_model.dart';

import '../../../../core/widgets/form_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key, required this.isLogin});
  final bool isLogin;
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEC=TextEditingController();
  final TextEditingController _passwordTEC=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  bool _check=false;
  bool _obscureText=true;
  bool _activityBar=false;
  bool _isTextFieldHeight=false;

  void _toggleChecked(){
    setState(() {
      _check= !_check;
    });
  }
  void _toggleObscured(){
    setState(() {
      _obscureText= !_obscureText;
    });
  }
  void _textFieldHeight(){
    _isTextFieldHeight=true;
    setState(() {});
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:const BackButtonSvg(),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 295,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Enter Your Email & Password',textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400 ),),
                      const SizedBox(height: 20,),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Email',textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      FormTextField(
                        boxHeight: _isTextFieldHeight? 60:null,
                        controller: _emailTEC,
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Input email',
                        suffixIcon: null,
                        obscureText: false,
                        validator: emailValidator,
                      ),
                      const SizedBox(height:8 ,),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Password',textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      FormTextField(
                        boxHeight:_isTextFieldHeight? 72 :null,
                        controller: _passwordTEC,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        hintText: 'Input password',
                        suffixIcon: IconButton(onPressed: (){
                          _toggleObscured();
                        }, icon:_obscureText
                            ? const Icon(Icons.remove_red_eye_rounded)
                            : Icon(Icons.remove_red_eye_outlined
                          ,color: Colors.redAccent.shade100,)),
                        obscureText: _obscureText,
                        validator: passWordValidator,
                      ),
                      const SizedBox(height: 1,),
                   widget.isLogin? const SizedBox(height: 10,) : Row(
                        children: [
                          IconButton(
                              onPressed: (){_toggleChecked();},
                              icon:_check
                                  ? const Icon(Icons.check_box,color: Color(0xFF8FAEFF),)
                                  :const Icon(Icons.check_box_outline_blank,)),
                          const Text('Save Password')
                        ],),
                      const SizedBox(height: 16,),
                      BlocBuilder<AuthBloc,AuthState>(
                        builder: (BuildContext context, state) {
                          if(state is AuthLoadingState){
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                              _activityBar=state.loadingBar;
                              setState(() {});
                            });

                          } else if(state is AuthFailureState ){
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                              if(mounted){
                               _activityBar=state.loadingBar;
                               setState(() {});
                              }
                            });
                          }
                          return widget.isLogin?CommonButton(
                              onPressed: (){
                            if(_formKey.currentState!.validate()){
                              context.read<AuthBloc>().add(
                                  AuthLoginEvent(
                                      email: _emailTEC.text,
                                      password: _passwordTEC.text,
                                      context: context));
                            }else{
                              return _textFieldHeight();
                            }
                          }, text: 'Log in') : CommonButton(onPressed: (){
                            if(_formKey.currentState!.validate()){
                              context.read<AuthBloc>().add(
                                  AuthRegisteredEvent(context,
                                      email: _emailTEC.text,
                                      password: _passwordTEC.text,
                                      userModel: UserModel(
                                          bio: '',
                                          displayName: '',
                                          email: _emailTEC.text,
                                          profilePictureURL: '',
                                          userName: '',
                                          follower: [],
                                          following: [],
                                          createdAt: DateTime.timestamp(),
                                          updatedAt: DateTime.timestamp())));
                            }else{
                              return _textFieldHeight();
                            }

                          }, text: 'Register');
                        },
                      )
                    ],),
                ),
              ),
            ),
          ),
          _activityBar
              ? Center(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.8)
                        : Colors.white70,
                    child: CupertinoActivityIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                      radius: 32,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
  }
}


