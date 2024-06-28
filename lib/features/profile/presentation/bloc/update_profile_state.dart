import 'package:equatable/equatable.dart';

abstract class UpdateProfileState extends Equatable{
  @override
  List<Object?> get props => [];
}
class InitializedUpdateProfileState extends UpdateProfileState{}
class LoadingUpdateProfileState extends UpdateProfileState{}
class LoadUpdateProfileState extends UpdateProfileState{}

class FailureUpdateProfileState extends UpdateProfileState{
 final String failureMessage;
 FailureUpdateProfileState({required this.failureMessage});
}
