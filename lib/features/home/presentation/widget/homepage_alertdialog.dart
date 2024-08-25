import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/widgets/spacing/spacing.dart';
import 'package:socia/core/widgets/button/svg_ink_button.dart';

class HomePageAlertDialog extends StatelessWidget {
  const HomePageAlertDialog({
    super.key,
    required ImagePicker imagePicker,
    required this.mounted,
  }) : _imagePicker = imagePicker;

  final ImagePicker _imagePicker;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          const Text('Select From',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SvgInkButton(
                      assetPath: AppIcons.camera,
                      isBGSurfaceWhite: true,
                      onTap: () async {
                        XFile? pickCameraImage = await _imagePicker.pickImage(
                            source: ImageSource.camera);
                        WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                      pictureHeight: 88,
                      pictureWidth: 88,
                    ),
                    const Text('Camera',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                  ],
                ),
                horizontalSpace(16),
                Column(
                  children: [
                    SvgInkButton(
                      assetPath: AppIcons.gallery,
                      isBGSurfaceWhite: true,
                      onTap: () async {
                        XFile? pickGalleryImage = await _imagePicker.pickImage(
                            source: ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      pictureHeight: 88,
                      pictureWidth: 88,
                    ),
                    const Text(
                      'Gallery',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
