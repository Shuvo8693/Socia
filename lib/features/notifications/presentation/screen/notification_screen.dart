import 'package:flutter/material.dart';
import 'package:socia/core/utility/dummypicturelink.dart';
import 'package:socia/core/widgets/button/back_button_svg.dart';

import '../../../../core/widgets/app_bar_title.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButtonSvg(),
        title: const AppBarTitle(
          title: 'Notification',
        ),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(DummyUrlImage.profile),
              ),
              title: titleTile(
                  textA: 'UserUUUUUUUUU', textB: 'User65654', context: context),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(DateTime.now().toString()),
              ),
            );
          }),
    );
  }

  Row titleTile(
      {required String textA, String? textB, required BuildContext context}) {
    return Row(
      children: [
        Expanded(
          child: RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: textA,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onPrimary)),
                  const TextSpan(text: ' '),
                  TextSpan(
                      text: 'commented on',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimary)),
                  const TextSpan(text: ' '),
                  TextSpan(
                      text: textB,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onPrimary)),
                ],
              )),
        )
      ],
    );
  }
}
