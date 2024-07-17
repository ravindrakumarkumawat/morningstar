import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:morningstar/presentation/theme/pallete.dart';
import 'package:morningstar/presentation/theme/typography.dart';

class HashtagText extends StatelessWidget {
  final String text;
  const HashtagText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textspans = [];

    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textspans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: AppTypography.fs16,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigator.push(
                //   context,
                //   HashtagView.route(element),
                // );
              },
          ),
        );
      } else if (element.startsWith('www.') || element.startsWith('https://')) {
        textspans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: AppTypography.fs16,
            ),
          ),
        );
      } else {
        textspans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              fontSize: AppTypography.fs16,
              color: Pallete.blackColor,
            ),
          ),
        );
      }
    });

    return RichText(
      text: TextSpan(
        children: textspans,
      ),
    );
  }
}
