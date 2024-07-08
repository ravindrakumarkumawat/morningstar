import 'package:flutter/material.dart';
import 'package:morningstar/common/tile/follow_tile.dart';
import 'package:morningstar/constants/ui_constants.dart';
import 'package:morningstar/features/dashboard/home_view.dart';
import 'package:morningstar/theme/theme.dart';
import 'package:morningstar/theme/typography.dart';

class AccountsList extends StatelessWidget {
  final appBar = UiConstants.appBar();
  AccountsList({super.key});

  final List<Map<String, dynamic>> followList = [
    {
      'avatar':
          'https://b.thumbs.redditmedia.com/zFfx3lgSSo7fcaRRZci8rVRnt7ZdAASez8cn0mQgJvY.jpg',
      'name': 'Vivekanadata',
      'username': '@viveka',
      'about':
          'Building Bounce along with Varun, Anil, Building Bounce Building Bounce along with Varun, Anilng with Varun, Anil Building Bounce along with Varun, Anil'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      appBar: appBar,
      body: ListView.builder(
        itemCount: followList.length * 10,
        itemBuilder: (context, index) {
          return FollowTile(
            follow: followList[0], // TODO: Index value change
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Pallete.greyColor))),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.blackColor,
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(width: 1.0, color: Colors.blueGrey),
                  ),
                  shadowColor: Pallete.whiteColor,
                ),
                onPressed: () {
                  Navigator.push(context, HomeView.route());
                },
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
      ),
    );
  }
}
