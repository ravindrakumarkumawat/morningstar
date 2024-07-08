import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/constants/ui_constants.dart';
import 'package:morningstar/features/twitter/views/create_tweet.dart';
import 'package:morningstar/theme/pallete.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appBar = UiConstants.appBar();

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
      appBar: appBar,
      body: IndexedStack(
        index: _page,
        children: UiConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: onCreateTweet,
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          )),
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
              FontAwesomeIcons.square,
              color: _page == 2 ? Pallete.blackColor : Pallete.greyColor,
              size: 24.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.userGroup,
              color: _page == 3 ? Pallete.blackColor : Pallete.greyColor,
              size: 24.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.bell,
              color: _page == 4 ? Pallete.blackColor : Pallete.greyColor,
              size: 24.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.envelope,
              color: _page == 5 ? Pallete.blackColor : Pallete.greyColor,
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
