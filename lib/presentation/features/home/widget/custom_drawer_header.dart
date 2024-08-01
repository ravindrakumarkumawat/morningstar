import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/presentation/common/avatar/avatar_image.dart';
import 'package:morningstar/presentation/common/loader/loader.dart';
import 'package:morningstar/presentation/theme/pallete.dart';
import 'package:morningstar/presentation/theme/typography.dart';
import 'package:morningstar/business_logic/blocs/users/users_bloc.dart';

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  State<CustomDrawerHeader> createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() {
    BlocProvider.of<UsersBloc>(context).add(CurrentUserDetails());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          return SizedBox(
            height: 220,
            child: StreamBuilder<DocumentSnapshot>(
              stream: state.userStream,
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                } else if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                  return const Text('No data available');
                } else {
                  final userDocs = userSnapshot.data!.data() as Map<String, dynamic>;
                  return UserDrawerHeaderContent(userDocs: userDocs);
                }
              },
            ),
          );
        } else {
          return const SizedBox(height: 220);
        }
      },
    );
  }
}

class UserDrawerHeaderContent extends StatelessWidget {
  final Map<String, dynamic> userDocs;

  const UserDrawerHeaderContent({Key? key, required this.userDocs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Pallete.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvatarImage(avatar: userDocs['image_url']),
              const SizedBox(height: 20),
              Text(
                userDocs['name'],
                style: const TextStyle(
                  fontSize: AppTypography.fs16,
                  fontWeight: FontWeight.bold,
                  color: Pallete.blackColor,
                ),
              ),
              Text(
                "@${userDocs['username']}",
                style: const TextStyle(
                  fontSize: AppTypography.fs14,
                  fontWeight: FontWeight.w400,
                  color: Pallete.greyColor,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: userDocs['following'].length.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: ' Following',
                      style: TextStyle(
                        fontSize: AppTypography.fs14,
                        fontWeight: FontWeight.w400,
                        color: Pallete.greyColor,
                      ),
                    ),
                    TextSpan(
                      text: ' ${userDocs['followers'].length}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: ' Followers',
                      style: TextStyle(
                        fontSize: AppTypography.fs14,
                        fontWeight: FontWeight.w400,
                        color: Pallete.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
