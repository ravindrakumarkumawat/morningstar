import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String noImplementation = 'Nothing here to see!';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

String getNameFromEmail(String email) {
  return email.split('@')[0];
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final imageFile = await picker.pickImage(source: ImageSource.gallery);
  if (imageFile != null) {
    return File(imageFile.path);
  }
  return null;
}

String generateRandomId() {
  var uuid = const Uuid();
  return uuid.v4();
}

bool validateEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  var status = regExp.hasMatch(email);
  return status;
}

void launchURL(String url) async {
  if (url == "") {
    return;
  }
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  } else {
    print('Could not launch $url');
  }
}

String getJoiningDate(String? date) {
  if (date == null || date.isEmpty) {
    return '';
  }
  var dt = DateTime.parse(date).toLocal();
  var dat = DateFormat("MMMM yyyy").format(dt);
  return 'Joined $dat';
}

void copyToClipBoard({
  required BuildContext context,
  required String text,
  required String message,
}) {
  var data = ClipboardData(text: text);
  Clipboard.setData(data);
  showSnackBar(context, message);
}

// Future<Uri> createLinkToShare(BuildContext context, String id,
//     {required SocialMetaTagParameters socialMetaTagParameters}) async {
//   final DynamicLinkParameters parameters = DynamicLinkParameters(
//     uriPrefix: 'https://fwitter.page.link',
//     link: Uri.parse('https://twitter.com/$id'),
//     androidParameters: AndroidParameters(
//       packageName: 'com.thealphamerc.flutter_twitter_clone_dev',
//       minimumVersion: 0,
//     ),
//     socialMetaTagParameters: socialMetaTagParameters,
//   );
//   Uri url;
//   final ShortDynamicLink shortLink =
//       await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//   url = shortLink.shortUrl;
//   return url;
// }
