import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socia/features/profile/data/models/update_user_model.dart';

abstract class UpdateProfileEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class LoadUpdateProfileEvent extends UpdateProfileEvent{
 final UpdateUserModel updateUserModel;
 final XFile imageFile;
 final BuildContext context;

  LoadUpdateProfileEvent({required this.updateUserModel,required this.imageFile,required this.context,});
}