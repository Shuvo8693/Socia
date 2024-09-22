abstract class ProfileImageState {}

class InitProfileImageState extends ProfileImageState {}

class LoadingProfileImageState extends ProfileImageState {}

class LoadedProfileImageState extends ProfileImageState {
 final String imageData;
  LoadedProfileImageState(this.imageData);
}

class FailureProfileImageState extends ProfileImageState {
 final String errorMessage;
  FailureProfileImageState(this.errorMessage);
}
