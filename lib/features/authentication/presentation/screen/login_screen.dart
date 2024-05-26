import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_sizes.dart';
import 'package:socia/core/widgets/common_button.dart';

import '../../../../core/widgets/form_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEC=TextEditingController();
  final TextEditingController _passwordTEC=TextEditingController();

  bool _check=false;
  bool _obscureText=true;

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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 360,
            width: 295,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter Your Email & Password',textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400 ),),
               const SizedBox(height: 30,),
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
                 controller: _emailTEC,
                 prefixIcon: const Icon(Icons.email_outlined),
                 hintText: 'Input email',
                 suffixIcon: null,
                 obscureText: false,
                 validator: ( String? value) {
                   return null;
                   },),
                const SizedBox(height:16 ,),
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
                 controller: _passwordTEC,
                 prefixIcon: const Icon(Icons.lock_outline_rounded),
                 hintText: 'Input password',
                 suffixIcon: IconButton(onPressed: (){
                   _toggleObscured();
                 }, icon:_obscureText
                     ? const Icon(Icons.remove_red_eye_outlined)
                       : Icon(Icons.remove_red_eye_outlined
                           ,color: Colors.redAccent.shade100,)),
                 obscureText: _obscureText,
                 validator: ( String? value) {
                   return null;
                   },),
                const SizedBox(height: 8,),
                Row(
                  children: [
                 IconButton(onPressed: (){_toggleChecked();},
                    icon:_check
                        ? const Icon(Icons.check_box,color: Color(0xFF8FAEFF),)
                        :const Icon(Icons.check_box_outline_blank,)),
                    const Text('Save Password')
                ],),
                const SizedBox(height: 20,),
                CommonButton(onPressed: (){}, text: 'Log in')
            ],),
          ),
        ),
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


