import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:morningstar/data_layer/data/models/tweets/tweets_model.dart';
import 'package:morningstar/data_layer/data/repositories/tweets_repository.dart';
import 'package:morningstar/presentation_layer/routes/routes.dart';
import 'package:morningstar/utils/utils.dart';

class CreateTweetScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const CreateTweetScreen(),
      );
  const CreateTweetScreen({super.key});

  @override
  State<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {
  TextEditingController _tweetTextController = TextEditingController();
  List<File> images = [];
  List<String> uploadedImagesUrl = [];
  @override
  void dispose() {
    super.dispose();
    _tweetTextController.dispose();
  }

  void shareTweet() {
    Navigator.pop(context);
  }

  void onPickImages() async {
    images = await pickImages();

    List<String> urls = [];
    for (File _image in images) {
      String url = await uploadImage(_image);
      if (url.isNotEmpty) {
        urls.add(url);
      }
    }
    uploadedImagesUrl = urls;
    setState(() {});
  }

  Future<String> uploadImage(File image) async {
    try {
      String randomID = generateRandomId();
      String fileName = 'images/$randomID.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<void> postTweet(BuildContext context) async {
    String randomUserID = generateRandomId();

    TweetModel tweetPayload = TweetModel(
      id: randomUserID,
      tweetedAt: DateTime.now().toIso8601String(),
      avatar: "https://randomuser.me/api/portraits/women/3.jpg",
      name: "Debolina watt",
      username: "debolinawatt",
      text: _tweetTextController.value.text,
      imageLinks: uploadedImagesUrl,
      tweetType: 'image',
      // TODO: Link implementation yet to be handled
      // link:
      //     'www.medium.com/@newtargetinc/twitter-api-is-no-longer-free-now-what-2a57e157696f',
      link: '',
      commentIds: [],
      reshareCount: 0,
      likes: [],
      retweetedBy: '',
      repliedTo: '',
    );

    if (_tweetTextController.value.text.isNotEmpty) {
      await TwittesRepository().addTweet(tweetPayload);
      if(context.mounted) Navigator.pushNamed(context, home);
    } else {
      showSnackBar(context, 'Please create interesting post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(width: 1.0, color: Colors.blueGrey),
              ),
              shadowColor: Colors.white,
            ),
            onPressed: () {
              postTweet(context);
            },
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    child: FaIcon(FontAwesomeIcons.user),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _tweetTextController,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                      decoration: const InputDecoration(
                        hintText: "What's happening?",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                  ),
                ],
              ),
              if (images.isNotEmpty)
                CarouselSlider(
                  items: images.map(
                    (file) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Image.file(file),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    height: 400,
                    enableInfiniteScroll: false,
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
            color: Colors.grey,
            width: 0.3,
          )),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 16.0,
                right: 16.0,
              ),
              child: GestureDetector(
                onTap: onPickImages,
                child: const FaIcon(
                  FontAwesomeIcons.image,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 16.0,
                right: 16.0,
              ),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.gif_box_outlined,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 16.0,
                right: 16.0,
              ),
              child: GestureDetector(
                onTap: () {},
                child: const FaIcon(
                  FontAwesomeIcons.listUl,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 16.0,
                right: 16.0,
              ),
              child: GestureDetector(
                onTap: () {},
                child: const FaIcon(
                  FontAwesomeIcons.locationDot,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
