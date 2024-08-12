import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:morningstar/business_logic/blocs/users/users_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/presentation/common/button/ripple_button.dart';
import 'package:morningstar/presentation/common/image/cache_image.dart';
import 'package:morningstar/presentation/common/image/cicular_image.dart';
import 'package:morningstar/presentation/common/loader/loader.dart';
import 'package:morningstar/presentation/constants/assets_constants.dart';
import 'package:morningstar/presentation/constants/custom_widgets.dart';
import 'package:morningstar/presentation/features/profile/widget/user_profile.dart';
import 'package:morningstar/presentation/features/profile/widget/tab_painter.dart';
import 'package:morningstar/presentation/features/twitter/views/create_tweet.dart';
import 'package:morningstar/presentation/routes/routes.dart';
import 'package:morningstar/presentation/theme/app_icon.dart';
import 'package:morningstar/presentation/theme/styles/styles.dart';
import 'package:morningstar/presentation/theme/theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  final String? bannerImage = null;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    getUserDetails();
  }

  void getUserDetails() {
    BlocProvider.of<UsersBloc>(context).add(UsersCurrentDetailsEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      floatingActionButton: _floatingActionButton(context),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              forceElevated: false,
              expandedHeight: 180,
              elevation: 0,
              stretch: true,
              iconTheme: const IconThemeData(color: Pallete.blackColor),
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                PopupMenuButton<Choice>(
                  color: Pallete.whiteColor,
                  onSelected: (d) {},
                  itemBuilder: (BuildContext context) {
                    return choices.map(
                      (Choice choice) {
                        return PopupMenuItem<Choice>(
                          value: choice,
                          child: Text(
                            choice.title,
                            style: TextStyles.textStyle14.copyWith(
                                color: choice.isEnable
                                    ? Pallete.blackColor
                                    : Pallete.greyColor),
                          ),
                        );
                      },
                    ).toList();
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground
                ],
                background: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    SizedBox.expand(
                      child: Container(
                        padding: const EdgeInsets.only(top: 50),
                        height: 50,
                      ),
                    ),
                    BlocBuilder<UsersBloc, UsersState>(
                      builder: (context, state) {
                        if (state is UserLoadedState) {
                          return Container(
                            height: 160,
                            padding: const EdgeInsets.only(
                              top: 28,
                            ),
                            child: StreamBuilder<DocumentSnapshot>(
                                stream: state.userStream,
                                builder: (context, userSnapshot) {
                                  if (userSnapshot.hasData) {
                                    final userDocs = userSnapshot.data!.data()
                                        as Map<String, dynamic>;
                                    return CacheImage(
                                      path: userDocs['banner_url'],
                                      fit: BoxFit.fill,
                                    );
                                  }
                                  return const CacheImage(
                                    path: AssetsConstants.defaultProfileBanner,
                                    fit: BoxFit.fill,
                                  );
                                }),
                          );
                        } else {
                          return Container(
                              height: 160,
                              padding: const EdgeInsets.only(
                                top: 28,
                              ),
                              color: Pallete.blackColor);
                        }
                      },
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          _profilePicAnimatedContainer(context),
                          _profileConditinalAction(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: UserProfileInfoRow(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  TabBar(
                    indicator: TabIndicator(),
                    controller: _tabController,
                    tabs: const <Widget>[
                      Text("Tweets"),
                      Text("Tweets & replies"),
                      Text("Media"),
                      Text("Likes"),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            Text('Hey first Tweets'),
            Text('Hey first Tweets & reply'),
            Text('Hey first Media'),
            Text('Hey Likes'),
          ],
        ),
      ),
    );
  }

  Widget _profilePicAnimatedContainer(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
        shape: BoxShape.circle,
      ),
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            return RippleButton(
              borderRadius: BorderRadius.circular(50),
              onPressed: () {},
              child: StreamBuilder<DocumentSnapshot>(
                stream: state.userStream,
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  } else if (!userSnapshot.hasData ||
                      !userSnapshot.data!.exists) {
                    return const CircularImage(
                      path: AssetsConstants.defaultProfilePic,
                      height: 80,
                    );
                  } else {
                    final userDocs =
                        userSnapshot.data!.data() as Map<String, dynamic>;
                    return CircularImage(
                      path: userDocs['image_url'],
                      height: 80,
                    );
                  }
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _profileConditinalAction(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 90,
        right: 30,
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          RippleButton(
            splashColor: Pallete.dodgeBlue_50.withAlpha(100),
            borderRadius: const BorderRadius.all(Radius.circular(60)),
            onPressed: () {
              Navigator.pushNamed(context, profileSetupPage);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Pallete.whiteColor,
                border: Border.all(
                  color: Colors.black87.withAlpha(180),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Edit profile',
                style: TextStyle(
                  color: Colors.black87.withAlpha(180),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, CreateTweetScreen.route());
      },
      child: customIcon(
        context,
        icon: AppIcon.fabTweet,
        isTwitterIcon: true,
        iconColor: Theme.of(context).colorScheme.onPrimary,
        size: 25,
      ),
    );
  }
}

class Choice {
  const Choice(
      {required this.title, required this.icon, this.isEnable = false});
  final bool isEnable;
  final IconData icon;
  final String title;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Share', icon: Icons.directions_car, isEnable: true),
  Choice(title: 'QR code', icon: Icons.directions_railway, isEnable: true),
  Choice(title: 'Draft', icon: Icons.directions_bike),
  Choice(title: 'View Lists', icon: Icons.directions_boat),
  Choice(title: 'View Moments', icon: Icons.directions_bus),
];
