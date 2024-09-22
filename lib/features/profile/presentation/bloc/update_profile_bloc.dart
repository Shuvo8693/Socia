import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/core/widgets/snacbar.dart';
import 'package:socia/features/profile/data/models/firestore_update_result.dart';
import 'package:socia/features/profile/data/service/update_profile_service.dart';
import 'package:socia/features/profile/presentation/bloc/update_profile_event.dart';
import 'package:socia/features/profile/presentation/bloc/update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileService updateProfileService;

  UpdateProfileBloc({required this.updateProfileService})
      : super(InitializedUpdateProfileState()) {
    on<LoadUpdateProfileEvent>(
        (event, emit) async => await onLoadUpdateProfileEvent(event, emit));
  }

  onLoadUpdateProfileEvent(event, emit) async {
    emit(LoadingUpdateProfileState());
    try {
      if (event is LoadUpdateProfileEvent) {
        await updateProfileService
            .requestToUpdateProfile(
                params: event.updateUserModel, imageFile: event.imageFile)
            .then(
          (UpdateResult value) {
            if (value.result) {
              snackBarMessage(
                  context: event.context,
                  title: 'Your profile successfully updated');
              emit(LoadUpdateProfileState());
              // Navigator.pushAndRemoveUntil(event.context, MaterialPageRoute(builder: (context)=>const  BottomNavBarScreen()),(route) =>false);
            } else {
              snackBarMessage(
                  context: event.context,
                  title: updateProfileService.errorMessage,
                  isColorRed: true);
              emit(LoadUpdateProfileState());
            }
          },
        );
      }
    } catch (error) {
      log(error.toString());
      emit(FailureUpdateProfileState(failureMessage: error.toString()));
    }
  }
}
