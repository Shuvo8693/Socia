
import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/widgets/common_form_field.dart';
import 'package:socia/core/widgets/svg_ink_button.dart';

import '../../../../core/utility/dummypicturelink.dart';
import '../../../../core/widgets/back_button_svg.dart';
import '../../../../core/widgets/profile_update_alertdialog.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  //final ValueNotifier<TextEditingController> _messageInputTEC=ValueNotifier(TextEditingController());
  final List<String> _message = [
    'sdfdfd65d4sd65f46d5sfd',
    'sdfdfd65d4sd65f46d5sfd',
    'sdfdfd65d4sd65f46d5sfd',
    'sdfdfd65d4sd65f46d5sfd',
    'sdfdfd65d4sd65f46d5sfd',
    'sdfdfd65d4sd65f46d5sfd',
  ];
  final TextEditingController _messageInputTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messageInputTEC.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _messageInputTEC.removeListener(_onTextChanged);
    _messageInputTEC.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const BackButtonSvg(),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          profileUpdateAlert();
                        },
                        child: ClipOval(
                          child: Image.network(
                            DummyUrlImage.profile,
                            fit: BoxFit.cover,
                            height: 32,
                            width: 32,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Text('Last Seen :',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      SvgInkButton(
                        assetPath: AppIcons.phone,
                        onTap: () {},
                        right: 12,
                        pictureWidth: 20,
                        pictureHeight: 22,
                      ),
                      SvgInkButton(
                        assetPath: AppIcons.video,
                        onTap: () {},
                        right: 8,
                        pictureWidth: 20,
                        pictureHeight: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Theme.of(context).brightness==Brightness.dark? Colors.grey.shade700 :Colors.grey.shade200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _message.length,
                              itemBuilder: (context, index) {
                                final receiveMsgIndex =
                                    _message[index];
                                return ChatBubble(receiveMsgIndex: receiveMsgIndex);
                              }),
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 65,
                width: double.infinity,
                child: inputMessageField(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row inputMessageField() {
    return Row(
      children: [
        Expanded(
          child: CommonFormField(
              controller: _messageInputTEC, hintText: 'Write Message'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:SvgInkButton(assetPath: AppIcons.send, onTap: () {}),
        ),
      ],
    );
  }

  void profileUpdateAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return ProfileUpdateDialog(
            onPressed: () {},
          );
        });
  }
}



class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.receiveMsgIndex,
  });

  final String receiveMsgIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.28),
                    topRight: Radius.circular(30.28),
                    bottomRight: Radius.circular(30.28)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(receiveMsgIndex,style: TextStyle(color: Theme.of(context).brightness==Brightness.dark? Colors.black:Colors.white),),
              )),
        ),
      ],
    );
  }
}
/*
return Padding(
padding: const EdgeInsets.all(5.0),
child: Container(
decoration: const BoxDecoration(
borderRadius: BorderRadius.only(
topLeft: Radius.circular(30.28),
topRight:
Radius.circular(30.28),
bottomRight:
Radius.circular(30.28)),
color: Colors.white,
),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Text(receiveMsgIndex),
)),
);
*/
