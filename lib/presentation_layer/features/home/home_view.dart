import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/constants/ui_constants.dart';
import 'package:morningstar/data_layer/data/repositories/auth_repository.dart';
import 'package:morningstar/presentation_layer/features/twitter/views/create_tweet.dart';
import 'package:morningstar/presentation_layer/routes/routes.dart';
import 'package:morningstar/presentation_layer/theme/pallete.dart';

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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Pallete.blackColor,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Pallete.whiteColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Profile'),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact'),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.rightFromBracket,
                color: Pallete.blackColor,
              ),
              title: Text('Logout'),
              onTap: () async {
                await AuthRepository().logout();
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
