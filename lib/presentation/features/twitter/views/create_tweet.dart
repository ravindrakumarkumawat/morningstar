import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:morningstar/business_logic/blocs/users/users_bloc.dart';
import 'package:morningstar/data/models/tweets/tweets_model.dart';
import 'package:morningstar/data/repositories/tweets_repository.dart';
import 'package:morningstar/presentation/utils/utils.dart';

class CreateTweetScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const CreateTweetScreen(),
      );
  const CreateTweetScreen({super.key});

  @override
  State<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {
  final TextEditingController _tweetTextController = TextEditingController();
  List<File> images = [];
  List<String> uploadedImagesUrl = [];

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() {
    BlocProvider.of<UsersBloc>(context).add(UsersCurrentDetailsDataEvent());
  }

  @override
  void dispose() {
    _tweetTextController.dispose();
    super.dispose();
  }

  Future<void> onPickImages() async {
    images = await pickImages();

    List<String> urls = [];
    for (File _image in images) {
      String url = await uploadImage(_image);
      if (url.isNotEmpty) {
        urls.add(url);
      }
    }
    setState(() {
      uploadedImagesUrl = urls;
    });
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
    if (_tweetTextController.value.text.isEmpty) {
      showSnackBar(context, 'Please create an interesting post');
      return;
    }

    final state = BlocProvider.of<UsersBloc>(context).state;

    if (state is UserLoadedStateData) {
      final userDetails = state.userData;
      if (userDetails == null) {
        showSnackBar(context, 'User is not valid!');
      } else {
        await submit(context, userDetails);
      }
    } else if (state is UserErrorState) {
      final errorMessage = state.message;
      showSnackBar(context, errorMessage);
    }
  }

  Future<void> submit(
      BuildContext context, Map<String, dynamic> userData) async {
    final User? user = FirebaseAuth.instance.currentUser;

    TweetModel tweetPayload = TweetModel(
      id: user!.uid,
      tweetedAt: DateTime.now().toIso8601String(),
      avatar: userData['image_url'],
      name: userData['name'],
      username: userData["username"],
      text: _tweetTextController.value.text,
      imageLinks: uploadedImagesUrl,
      tweetType: 'image',
      link: '',
      commentIds: [],
      reshareCount: 0,
      likes: [],
      retweetedBy: '',
      repliedTo: '',
    );

    await TwittesRepository().addTweet(tweetPayload);
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildContent(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
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
          if (images.isNotEmpty) _buildImageCarousel(),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return CarouselSlider(
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
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
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
          _buildBottomIcon(
            icon: const FaIcon(FontAwesomeIcons.image),
            onTap: onPickImages,
          ),
          _buildBottomIcon(
            icon: const Icon(Icons.gif_box_outlined),
            onTap: () {},
          ),
          _buildBottomIcon(
            icon: const FaIcon(FontAwesomeIcons.listUl),
            onTap: () {},
          ),
          _buildBottomIcon(
            icon: const FaIcon(FontAwesomeIcons.locationDot),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBottomIcon({required Widget icon, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: icon,
      ),
    );
  }
}
