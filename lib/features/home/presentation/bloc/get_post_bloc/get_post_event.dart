import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


abstract class GetPostEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class StartedGetPostEvent extends GetPostEvent{}
class LoadedGetPostEvent extends GetPostEvent{}