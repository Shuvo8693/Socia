import 'package:flutter/material.dart';

import '../../config/theme/app_color.dart';
import '../utility/dummypicturelink.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.imageIndex,
    required bool shouldUseAddIcon, required this.onTab, required this.text,
  }) : _shouldUseAddIcon = shouldUseAddIcon;

  final String imageIndex;
  final bool _shouldUseAddIcon;
  final Function() onTab;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 154,
          width:96 ,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1, 0)
              )
            ]
          ),

          child:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(text),
              const SizedBox(height: 5,)
            ],
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: InkWell(
              onTap: onTab,
              child: Container(
                height: 128,
                width:96 ,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: NetworkImage(imageIndex),fit: BoxFit.cover)
                ),
                // child: Image.network(imageIndex,fit: BoxFit.fill,),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height:28 ,
            width: 28,
            child: CircleAvatar(
              backgroundImage: NetworkImage(DummyUrlImage.profile),
              backgroundColor: Colors.grey,
            ),
          ),
        ),
        _shouldUseAddIcon?
        const Positioned(
            left: 40,
            top: 60,
            child: Icon(Icons.add,size: 35,color: Colors.white,))
            : const SizedBox(),

      ],
    );
  }
}