import 'package:flutter/material.dart';
import 'package:socia/core/widgets/app_bar_title.dart';
import 'package:socia/core/widgets/form_text_field.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'Add Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 52,
              width: 375,
              child: FormTextField(
                controller: TextEditingController(),
                prefixIcon: const Icon(Icons.search_outlined),
                hintText: 'Input Text',
                boxHeight: 36,
                boxWidth: 343,
              ),
            ),
            const ListTile(
              title: Text(
                'Jamuna Future Park',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                'progati sarani,kuril,badda',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
