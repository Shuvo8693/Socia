import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class StoryEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class ImageAndProfileLoadStoryEvent extends StoryEvent{}
class AddImageStoryEvent extends StoryEvent{
  final XFile image;
  final BuildContext context;

  AddImageStoryEvent({required this.image,required this.context});
}

class FailureStoryEvent extends StoryEvent{}