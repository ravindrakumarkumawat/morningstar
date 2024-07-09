import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
    setState(() {});
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
            onPressed: () {},
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
