import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_color.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/utility/dummypicturelink.dart';
import 'package:socia/core/widgets/common_form_field.dart';
import 'package:socia/features/post/presentation/screen/add_location.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/blue_text_button.dart';

class UploadContent extends StatefulWidget {
  const UploadContent({super.key});

  @override
  State<UploadContent> createState() => _UploadContentState();
}

class _UploadContentState extends State<UploadContent> {
  final TextEditingController _captionTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'New Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlueTextButton(
              onPressed: () {
                alertPost();
              },
              text: 'Post',
              isIconSet: true,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  DummyUrlImage.profile,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                Expanded(
                    child: CommonFormField(
                        controller: _captionTEC,
                        maxLine: 3,
                        hintText: 'Write a Caption')),
              ],
            ),
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddLocation()));
            },
            title: const Text('Add location'),
          ),
          const Divider(
            height: 2,
          ),
        ],
      ),
    );
  }

  void alertPost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: Image.asset(
              AppIcons.user,
              height: 34,
              width: 34,
            ),
            title: const Text(
              'Do you want to post ?',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            content: const Text(
              'Your post will share by clicking yes, if need any change click on edit.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.alertPostContentColor),
            ),
            actions:  [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const SizedBox(width: 10,),
                BlueTextButton(
                    text: 'Edit',
                    isIconSet: false,
                    onPressed: (){
                      Navigator.pop(context);
                    }),
                ElevatedButton(onPressed: (){}, child: const Text('Post Now')),
              ],),

            ],
          );
        });
  }
}
