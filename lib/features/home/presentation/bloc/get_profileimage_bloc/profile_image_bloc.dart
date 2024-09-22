import 'package:socia/features/home/data/service/profileimage_service.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_event.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_state.dart';
import 'package:socia/home_screen_imports.dart';

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  ProfileImageService profileImageService;

  ProfileImageBloc(this.profileImageService)
      : super(InitProfileImageState()) {
    on<LoadProfileImageEvent>(
        (event, emit) async => await onLoadProfileImage(event, emit));
  }

  onLoadProfileImage(event, emit) async {
    emit(LoadingProfileImageState());
    final result = await profileImageService.fetchProfileImage();
    result.fold(
      (failure) {
        return emit(FailureProfileImageState(failure));
      },
      (imageData) {
        return emit(LoadedProfileImageState(imageData));
      },
    );
  }
}
