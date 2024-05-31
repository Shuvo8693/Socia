
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socia/core/utility/dummypicturelink.dart';
import 'package:socia/core/widgets/back_button_svg.dart';
import '../../../../core/widgets/app_bar_title.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Padding(
          padding: EdgeInsets.all(16.5),
          child: BackButtonSvg(),
        ),
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
                  textA: 'UserUUUUUUUUU',
                  textB: 'User65654'),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(DateTime.now().toString()),
              ),
            );
          }),
    );
  }

  Row titleTile({required String textA, String? textB}) {
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
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const TextSpan(text: ' '),
                  const TextSpan(
                      text: 'commented on',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  const TextSpan(text: ' '),
                  TextSpan(
                      text: textB,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              )),
        )
      ],
    );
  }
}
