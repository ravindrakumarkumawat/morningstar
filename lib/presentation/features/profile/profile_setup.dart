import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/presentation/constants/ui_constants.dart';
import 'package:morningstar/presentation/features/profile/widget/profile_picture_upload.dart';
import 'package:morningstar/presentation/theme/theme.dart';
import 'package:morningstar/presentation/theme/typography.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileLayout(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Pick a profile picture', style: TextStyle(color: Pallete.blackColor, fontSize: AppTypography.fs22, fontWeight: FontWeight.w700,),),
            SizedBox(height: 12,),
            Text('Have a favorite selfie? Upload it now.', style: TextStyle(color: Pallete.greyColor, fontSize: AppTypography.fs16, fontWeight: FontWeight.w400,),),
            SizedBox(height: 32,),
            ProfilePictureUpload(),
          ],
        ),
      ),
    );
  }
}

class ProfileLayout extends StatelessWidget {
  final Widget body;
  const ProfileLayout({super.key, required this.body});
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
      body: body,
      bottomNavigationBar: ProfileBottomActionBar(onPressed: () {}),
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
