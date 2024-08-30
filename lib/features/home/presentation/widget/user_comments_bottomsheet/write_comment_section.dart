import 'package:flutter/material.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/widgets/spacing/spacing.dart';
import 'package:socia/home_screen_imports.dart';

class WriteCommentSection extends StatefulWidget {
  const WriteCommentSection({
    super.key,
  });

  @override
  State<WriteCommentSection> createState() => _WriteCommentSectionState();
}

class _WriteCommentSectionState extends State<WriteCommentSection> {
  final TextEditingController _commentsTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.rW),
      child: SizedBox(
        height: 65.rH,
        child: Row(
          children: [
            SizedBox(
              height: 35.rH,
              width: 35.rH,
              child: ClipOval(
                child: Image.network(
                  DummyUrlImage.profile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            horizontalSpace(8.rW),
            Expanded(
              child: CommonFormField(
                controller: _commentsTEC,
                hintText: 'Write Comment...',
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Post',
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _commentsTEC.dispose();
  }
}
