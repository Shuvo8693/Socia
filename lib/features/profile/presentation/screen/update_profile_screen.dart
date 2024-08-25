import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socia/config/theme/app_sizes.dart';
import 'package:socia/core/utility/assets_image.dart';
import 'package:socia/core/widgets/app_bar_title.dart';
import 'package:socia/core/widgets/button/back_button_svg.dart';
import 'package:socia/core/widgets/button/common_button.dart';
import 'package:socia/core/widgets/form_text_field.dart';
import 'package:socia/features/profile/data/models/update_user_model.dart';
import 'package:socia/features/profile/presentation/bloc/update_profile_bloc.dart';
import 'package:socia/features/profile/presentation/bloc/update_profile_event.dart';
import 'package:socia/features/profile/presentation/bloc/update_profile_state.dart';
import 'package:socia/features/profile/presentation/widget/profile_image_selector.dart';



class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _bioTEC = TextEditingController();
  final TextEditingController _displayNameTEC = TextEditingController();
  final TextEditingController _userNameTEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButtonSvg(),
        title: const AppBarTitle(title: 'Update Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: _imageFile != null
                          ? FileImage(File(_imageFile!.path)) as ImageProvider
                          : AssetImage(AssetImg.noPersonImg),
                      backgroundColor: Colors.grey,
                      maxRadius: 60,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ProfileImageSelector(
                        onTap: () async => await selectProfileImage(),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                _displayNameTEC.text.isNotEmpty
                    ? namingText(
                        text: _displayNameTEC.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)
                    : namingText(
                        text: 'Display Name',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                _userNameTEC.text.isNotEmpty
                    ? namingText(text: _userNameTEC.text)
                    : namingText(text: 'userName654'),
                const SizedBox(
                  height: 25,
                ),
                FormTextField(
                  controller: _bioTEC,
                  hintText: 'Bio',
                  boxHeight: 80,
                  maxLine: 3,
                  contentPadding: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormTextField(
                  controller: _displayNameTEC,
                  hintText: 'Display Name',
                  boxHeight: 60,
                  contentPadding: 10,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter Display name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormTextField(
                  controller: _userNameTEC,
                  hintText: 'User Name',
                  boxHeight: 60,
                  contentPadding: 10,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter userName';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                  builder: (BuildContext context, state) {
                    if (state is LoadingUpdateProfileState) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (state is FailureUpdateProfileState) {
                      log(state.failureMessage);
                    } else if (state is LoadUpdateProfileState) {
                      return CommonButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            context.read<UpdateProfileBloc>().add(
                                LoadUpdateProfileEvent(
                                    updateUserModel: UpdateUserModel(
                                        userName: _userNameTEC.text,
                                        displayName: _displayNameTEC.text,
                                        bio: _bioTEC.text),
                                    imageFile: _imageFile ?? XFile(''),
                                    context: context));
                          },
                          text: 'Update');
                    }
                    return CommonButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          context.read<UpdateProfileBloc>().add(
                              LoadUpdateProfileEvent(
                                  updateUserModel: UpdateUserModel(
                                      userName: _userNameTEC.text,
                                      displayName: _displayNameTEC.text,
                                      bio: _bioTEC.text),
                                  imageFile: _imageFile ?? XFile(''),
                                  context: context));
                        },
                        text: 'Update');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text namingText(
          {required String text, double? fontSize, FontWeight? fontWeight}) =>
      Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      );

  selectProfileImage() async {
    final XFile? imageData =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (!mounted) return;
    setState(() {
      _imageFile = imageData;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bioTEC.dispose();
    _displayNameTEC.dispose();
    _userNameTEC.dispose();
  }
}
