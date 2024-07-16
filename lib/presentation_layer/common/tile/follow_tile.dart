import 'package:flutter/material.dart';
import 'package:morningstar/presentation_layer/common/avatar/avatar_image.dart';
import 'package:morningstar/presentation_layer/theme/theme.dart';
import 'package:morningstar/presentation_layer/theme/typography.dart';

class Avatar extends StatelessWidget {
  final String avatar;
  final String name;
  final bool isVerified;
  final String username;
  const Avatar({
    super.key,
    required this.avatar,
    required this.name,
    this.isVerified = false,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AvatarImage(avatar: avatar),
      title: Text(
        name,
        style: const TextStyle(
          color: Pallete.blackColor,
          fontWeight: FontWeight.w700,
          fontSize: AppTypography.fs16,
        ),
      ),
      subtitle: Text(
        username,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.w400,
          fontSize: AppTypography.fs14,
        ),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.blackColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 2.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              width: 1.0,
              color: Pallete.blackColor,
            ),
          ),
          shadowColor: Pallete.blackColor,
        ),
        onPressed: () {},
        child: const Text(
          'Follow',
          style: TextStyle(
            color: Pallete.whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: AppTypography.fs16,
          ),
        ),
      ),
    );
  }
}

class FollowTile extends StatelessWidget {
  final Map<String, dynamic> follow;
  const FollowTile({
    super.key,
    required this.follow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Avatar(
          name: follow['name'],
          username: follow['username'],
          avatar: follow['avatar'],
        ),
        Padding(
            padding: const EdgeInsets.only(
              left: 70.0,
              right: 16.0,
            ),
            child: Text(
              follow['about'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Pallete.blackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: AppTypography.fs14),
            ))
      ],
    );
  }
}
