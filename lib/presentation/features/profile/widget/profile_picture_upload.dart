import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/presentation/constants/ui_constants.dart';
import 'package:morningstar/presentation/theme/theme.dart';
import 'package:morningstar/presentation/theme/typography.dart';
import 'package:morningstar/presentation/utils/utils.dart';

class ProfilePictureUpload extends StatefulWidget {
  // final Function(File) onImagePicked;

  const ProfilePictureUpload({super.key});

  @override
  State<ProfilePictureUpload> createState() => _ProfilePictureUploadState();
}

class _ProfilePictureUploadState extends State<ProfilePictureUpload> {
  File? _selectedImage;

  void onPickImage() async {
    _selectedImage = await pickImage();
    if (_selectedImage != null) {
      // widget.onImagePicked(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = UiConstants.appBar(
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: ProfileBottomActionBar(onPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Pick a profile picture',
              style: TextStyle(
                color: Pallete.blackColor,
                fontSize: AppTypography.fs22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Have a favorite selfie? Upload it now.',
              style: TextStyle(
                color: Pallete.greyColor,
                fontSize: AppTypography.fs16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Center(
              child: GestureDetector(
                onTap: onPickImage,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(
                      width: 2.0,
                      color: Pallete.blackColor,
                      style: BorderStyle.solid,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: _selectedImage == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Pallete.blackColor,
                                  size: 120,
                                ),
                                onPressed: onPickImage,
                              ),
                              const Text(
                                'Upload',
                                style: TextStyle(
                                  color: Pallete.blackColor,
                                  fontSize: AppTypography.fs16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBottomActionBar extends StatelessWidget {
  const ProfileBottomActionBar({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Pallete.greyColor))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.whiteColor,
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side:
                        const BorderSide(width: 1.0, color: Pallete.greyColor)),
                shadowColor: Pallete.whiteColor,
              ),
              onPressed: () {},
              child: const Text(
                'Skip for now',
                style: TextStyle(
                  color: Pallete.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: AppTypography.fs16,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.blackColor,
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(width: 1.0, color: Pallete.blackColor),
                ),
                shadowColor: Pallete.whiteColor,
              ),
              onPressed: () {},
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Pallete.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: AppTypography.fs16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
