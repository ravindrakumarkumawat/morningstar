import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morningstar/common/avatar/avatar_image.dart';
import 'package:morningstar/constants/assets_constants.dart';
import 'package:morningstar/features/twitter/views/twitter_reply_view.dart';
// import 'package:morningstar/core/enums/tweet_type_enum.dart';
import 'package:morningstar/features/twitter/widgets/carousel_image.dart';
import 'package:morningstar/features/twitter/widgets/hashtag.dart';
import 'package:morningstar/features/twitter/widgets/tweet_icon_button.dart';
import 'package:morningstar/theme/theme.dart';
import 'package:morningstar/theme/typography.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends StatelessWidget {
  final Map<String, dynamic> tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = {'uid': '13'};

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          TwitterReplyScreen.route(tweet),
        );
      },
      child: Column(
        children: [
          const SizedBox(height: 8),
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
                    if (tweet['retweetedBy'].isNotEmpty)
                      Row(
                        children: [
                          SvgPicture.asset(
                            AssetsConstants.retweetIcon,
                            color: Pallete.greyColor,
                            height: 20,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${tweet['retweetedBy']} retweeted',
                            style: const TextStyle(
                              color: Pallete.greyColor,
                              fontSize: AppTypography.fs16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
                          '@${tweet["username"]} · ${timeago.format(
                            DateTime.parse(tweet[
                                "tweetedAt"]), // Todo: Need to add fix for this
                            locale: 'en_short',
                          )}',
                          // '${tweet["username"]} . ${tweet["tweetedAt"]}',
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400,
                            fontSize: AppTypography.fs14,
                          ),
                        ),
                      ],
                    ),
                    // Replied to
                    HashtagText(
                      text: tweet['text'],
                    ),
                    // if (tweet['tweetType'] == TweetType.image)
                    if (tweet['tweetType'] == 'image')
                      CarouselImage(imageLinks: tweet['imageLinks'].cast<String>()),
                    if (tweet['link'].isNotEmpty) ...[
                      const SizedBox(height: 4),
                      AnyLinkPreview(
                        displayDirection: UIDirection.uiDirectionHorizontal,
                        link: "https://${tweet['link']}",
                      ),
                    ],
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TweetIconButton(
                            pathName: AssetsConstants.viewsIcon,
                            text: (tweet['commentIds']?.length +
                                    tweet['reshareCount'] +
                                    tweet['likes']?.length)
                                .toString(),
                            onTap: () {},
                          ),
                          TweetIconButton(
                            pathName: AssetsConstants.commentIcon,
                            text: (tweet['commentIds']?.length).toString(),
                            onTap: () {},
                          ),
                          TweetIconButton(
                            pathName: AssetsConstants.retweetIcon,
                            text: (tweet['reshareCount']).toString(),
                            onTap: () {},
                          ),
                          LikeButton(
                            size: 25,
                            onTap: (isLiked) async {
                              return !isLiked;
                            },
                            isLiked:
                                tweet['likes'].contains(currentUser['uid']),
                            likeBuilder: (isLiked) {
                              return isLiked
                                  ? SvgPicture.asset(
                                      AssetsConstants.likeFilledIcon,
                                      color: Pallete.redColor,
                                    )
                                  : SvgPicture.asset(
                                      AssetsConstants.likeOutlinedIcon,
                                      color: Pallete.greyColor,
                                    );
                            },
                            likeCount: (tweet['likes]'])?.length,
                            countBuilder: (likeCount, isLiked, text) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    color: isLiked
                                        ? Pallete.redColor
                                        : Pallete.blackColor,
                                    fontSize: AppTypography.fs16,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share_outlined,
                              size: 25,
                              color: Pallete.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Pallete.greyColor,
            height: 1,
          ),
        ],
      ),
    );
  }
}
