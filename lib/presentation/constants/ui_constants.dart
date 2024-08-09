import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/presentation/features/twitter/widgets/tweet_list.dart';

class UiConstants {
  static AppBar appBar({ Widget? leading }) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const FaIcon(FontAwesomeIcons.xTwitter),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: leading,
    );
  }

  static List<Widget> bottomTabBarPages = [
    TweetList(),
    const Text('Search Screen'),
    const Text('Notification Screen'),
    const Text('Envelop Screen'),
  ];
}
