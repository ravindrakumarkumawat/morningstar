import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/business_logic/blocs/users/users_bloc.dart';
import 'package:morningstar/data/models/user/user_model.dart';
import 'package:morningstar/presentation/common/loader/loader.dart';
import 'package:morningstar/presentation/common/url/url_text.dart';
import 'package:morningstar/presentation/constants/custom_widgets.dart';
import 'package:morningstar/presentation/theme/app_icon.dart';
import 'package:morningstar/presentation/theme/styles/styles.dart';
import 'package:morningstar/presentation/theme/theme.dart';
import 'package:morningstar/presentation/utils/utils.dart';

class UserProfileInfoRow extends StatelessWidget {
  UserProfileInfoRow({
    super.key,
  });

  final UserModel user = UserModel(
    name: 'John Doe',
    userName: '@johndoe',
    isVerified: true,
    bio: 'Edit profile to update bio',
    location: 'New York, NY',
    createdAt: '2020-01-01T00:00:00Z',
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          return Container(
            child: StreamBuilder<DocumentSnapshot>(
              stream: state.userStream,
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                } else if (!userSnapshot.hasData ||
                    !userSnapshot.data!.exists) {
                  return const Text('No data available');
                } else {
                  final userDocs = userSnapshot.data!.data() as Map<String, dynamic>;
                  return UserProfileInfo(user: userDocs);
                }
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class UserProfileInfo extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserProfileInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: <Widget>[
              UrlText(
                text: user['name'],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              // user.isVerified!
              true
                  ? customIcon(context,
                      icon: AppIcon.blueTick,
                      isTwitterIcon: true,
                      iconColor: AppColor.primary,
                      size: 13,
                      paddingIcon: 3)
                  : const SizedBox(width: 0),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: customText(
            '@${user['username']}',
            style: TextStyles.subtitleStyle.copyWith(fontSize: 13),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: customText(
            user['bio'],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              customIcon(context,
                  icon: AppIcon.locationPin,
                  size: 14,
                  isTwitterIcon: true,
                  paddingIcon: 5,
                  iconColor: AppColor.darkGrey),
              const SizedBox(width: 10),
              Expanded(
                child: customText(
                  user['location'],
                  style: const TextStyle(color: AppColor.darkGrey),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: <Widget>[
              customIcon(context,
                  icon: AppIcon.calender,
                  size: 14,
                  isTwitterIcon: true,
                  paddingIcon: 5,
                  iconColor: AppColor.darkGrey),
              const SizedBox(width: 10),
              customText(
                getJoiningDate(user['created_at']),
                style: const TextStyle(color: AppColor.darkGrey),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
                height: 30,
              ),
              _textButton(context, user['followers'].length.toString(), ' Followers', () {}),
              const SizedBox(width: 40),
              _textButton(context, user['following'].length.toString(), ' Following', () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _textButton(
    BuildContext context,
    String count,
    String text,
    Function onPressed,
  ) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Row(
        children: <Widget>[
          customText(
            '$count ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          customText(
            text,
            style: const TextStyle(color: AppColor.darkGrey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
