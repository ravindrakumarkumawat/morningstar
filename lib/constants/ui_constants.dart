import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/features/twitter/widgets/tweet_list.dart';

class UiConstants {
  static AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const FaIcon(FontAwesomeIcons.xTwitter),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  static List<Widget> bottomTabBarPages = [
    TweetList(),
    Text('Search Screen'),
    Text('Square Screen'),
    Text('Group Screen'),
    Text('Notification Screen'),
    Text('Envelop Screen'),
  ];
}
