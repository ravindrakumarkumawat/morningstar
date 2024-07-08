import 'package:flutter/material.dart';
import 'package:morningstar/common/avatar/avatar_image.dart';
import 'package:morningstar/features/twitter/widgets/carousel_image.dart';
import 'package:morningstar/features/twitter/widgets/hashtag.dart';
import 'package:morningstar/theme/theme.dart';
import 'package:morningstar/theme/typography.dart';

class TweetCard extends StatelessWidget {
  final Map<String, dynamic> tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: AvatarImage(
                    avatar: tweet['avatar'],
                  ),
                ),
              ),
              // CircleAvatar(
              //   backgroundImage: Image.network(tweet['avatar']),
              //   radius: 35,
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Retweeted
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: Text(
                            tweet['name'],
                            style: const TextStyle(
                              color: Pallete.blackColor,
                              fontWeight: FontWeight.w700,
                              fontSize: AppTypography.fs16,
                            ),
                          ),
                        ),
                        Text(
                          // '\$tweet["username"] · \${timeago.format(
                          //   tweet["tweetedAt"],
                          //   locale: 'en_short',
                          // )}',
                          '${tweet["username"]} . ${tweet["tweetedAt"]}',
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400,
                            fontSize: AppTypography.fs14,
                          ),
                        ),
                      ],
                    ),
                    // Replied to
                    HashtagText(text: tweet['text'],),
                    // if()
                    // CarouselImage(imageLinks: tweet['imageLink'])
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
