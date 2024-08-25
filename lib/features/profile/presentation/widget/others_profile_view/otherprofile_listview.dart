import 'package:flutter/material.dart';

class OtherProfileListView extends StatelessWidget {
  const OtherProfileListView({
    super.key,
    required this.imageUrl,
  });

  final List<String> imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: imageUrl.length,
        itemBuilder: (context, index) {
          final imageUelIndex = imageUrl[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUelIndex,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}