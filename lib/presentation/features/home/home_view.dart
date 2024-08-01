import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/business_logic/blocs/authentication/auth_bloc.dart';
import 'package:morningstar/business_logic/blocs/authentication/auth_event.dart';
import 'package:morningstar/presentation/constants/ui_constants.dart';
import 'package:morningstar/presentation/features/home/widget/custom_drawer_header.dart';
import 'package:morningstar/presentation/features/twitter/views/create_tweet.dart';
import 'package:morningstar/presentation/routes/routes.dart';
import 'package:morningstar/presentation/theme/pallete.dart';
import 'package:morningstar/presentation/theme/typography.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  void onCreateTweet() {
    Navigator.push(context, CreateTweetScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const FaIcon(FontAwesomeIcons.xTwitter),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.user,
            color: Pallete.blackColor,
            size: 20,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.gear,
              color: Pallete.blackColor,
              size: 20,
            ),
            onPressed: () {
              // Navigator.pop(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Pallete.whiteColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const CustomDrawerHeader(),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Pallete.blackColor,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: AppTypography.fs16,
                  fontWeight: FontWeight.bold,
                  color: Pallete.blackColor,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, profilePage);
              },
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.rightFromBracket,
                color: Pallete.blackColor,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: AppTypography.fs16,
                  fontWeight: FontWeight.bold,
                  color: Pallete.blackColor,
                ),
              ),
              onTap: () async {
                BlocProvider.of<AuthBloc>(context).add(LogOutUser());
                if (context.mounted) {
                  Navigator.pushNamed(
                    context,
                    welcome,
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _page,
        children: UiConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTweet,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: _page == 0 ? Pallete.blackColor : Pallete.greyColor,
              size: 24.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: _page == 1 ? Pallete.blackColor : Pallete.greyColor,
              size: 24.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.bell,
              color: _page == 2 ? Pallete.blackColor : Pallete.greyColor,
              size: 24.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.envelope,
              color: _page == 3 ? Pallete.blackColor : Pallete.greyColor,
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
