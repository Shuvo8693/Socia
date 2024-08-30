import 'package:flutter/material.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/widgets/button/svg_ink_button.dart';
import 'package:socia/core/widgets/spacing/spacing.dart';
import 'package:socia/home_screen_imports.dart';

class CommentsDisplaySection extends StatelessWidget {
  const CommentsDisplaySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 375.rH,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(8.0.rP),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.rW),
                    child: SizedBox(
                      height: 32.rH,
                      width: 32.rH,
                      child: ClipOval(
                        child: Image.network(
                          DummyUrlImage.profile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'UserName',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          horizontalSpace(10.rW),
                          const Text('2 hours ago'),
                        ],
                      ),
                      Text(
                        'Nice pictures of your travel',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              SvgInkButton(
                assetPath: AppIcons.loveLine,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
