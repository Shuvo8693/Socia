import 'package:flutter/material.dart';

class OtherProfileGridView extends StatelessWidget {
  const OtherProfileGridView({
    super.key,
    required this.imageUrl,
  });

  final List<String> imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: imageUrl.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (context, index) {
          final imageUelIndex = imageUrl[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUelIndex,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}