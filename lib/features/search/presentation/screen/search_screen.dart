import 'package:flutter/material.dart';
import 'package:socia/core/widgets/form_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTEC = TextEditingController();
  List<String> imageUrl = [
    'https://media.istockphoto.com/id/1001021150/photo/muslim-man-is-praying-in-mosque.webp?s=1024x1024&w=is&k=20&c=SjMLzeG1LbNne_wYOHM1rKem4K813PIhRg9yO02FTYo=',
    'https://media.istockphoto.com/id/1149556870/photo/muslim-man-is-praying-in-mosque.webp?s=1024x1024&w=is&k=20&c=J-6dfumiT0-kV4Enmn8yNt_Ya6vVSveLB9STauDrCjo=',
    'https://media.istockphoto.com/id/513115670/photo/religious-muslim-man-reading-holy-koran.webp?s=1024x1024&w=is&k=20&c=y7G--UCsp-PXsYX0lgkz79V4WJCKyyRU9EK71LnU9ko=',
    'https://media.istockphoto.com/id/1139230133/photo/man-holding-prayer-beads-while-praying-at-mosque.webp?s=1024x1024&w=is&k=20&c=rVxNrePkjrWmW79WCXpksmlre-gkOsBq_9ofgoJYw88=',
    'https://media.istockphoto.com/id/545376750/photo/young-muslim-man-praying.webp?s=1024x1024&w=is&k=20&c=wMNoAyiN7SbifRpiC7CoCpvDWGOSbkxO2DSa8VPf3-c=',
    'https://images.unsplash.com/photo-1560601575-29dc7d25ff3b?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://media.istockphoto.com/id/1311358706/photo/a-portrait-of-a-man-in-abdesthana-using-a-towel.webp?s=1024x1024&w=is&k=20&c=2z2BN7ZwZdsE3z_5fZgioBRWTnC8HKBXJqOYNtPR4wE=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 12,
              right: 12,
            ),
            child: Column(
              children: [
                FormTextField(
                  controller: _searchTEC,
                  prefixIcon: const Icon(Icons.search_outlined),
                  hintText: 'Search',
                  boxWidth: 343,
                  boxHeight: 36,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 15, right: 15),
                    child: GridView.builder(
                        itemCount: imageUrl.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3),
                        itemBuilder: (context, index) {
                          final imageUrlIndex = imageUrl.elementAt(index);
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrlIndex,
                                fit: BoxFit.cover,
                              ));
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
