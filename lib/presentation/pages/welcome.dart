import 'package:flutter/material.dart';
import 'package:morningstar/presentation/constants/ui_constants.dart';
import 'package:morningstar/presentation/routes/routes.dart';
import 'package:morningstar/presentation/theme/theme.dart';
import 'package:morningstar/presentation/theme/typography.dart';
import 'package:morningstar/presentation/utils/utils.dart';

class Welcome extends StatelessWidget {
  final appBar = UiConstants.appBar();
  Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                "See what's happening in the world right now.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Pallete.blackColor,
                  fontSize: 36,
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              // TODO: Later will add
              // _googleLoginButton(context),
              // const SizedBox(
              //   height: 10,
              // ),
              // _seperator(),
              const SizedBox(
                height: 10,
              ),
              _createAccountButton(context),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Terms and Conditions apply.',
                style: TextStyle(
                  fontSize: AppTypography.fs16,
                  color: Pallete.greyColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    login,
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Pallete.blueColor,
                    decoration: TextDecoration.none,
                    fontSize: AppTypography.fs16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ConstrainedBox _googleLoginButton(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: const BorderSide(
                width: 1.0,
                color: Pallete.greyColor,
              ),
            ),
            shadowColor: Pallete.whiteColor,
            backgroundColor: Pallete.whiteColor,
          ),
          onPressed: () {
            showSnackBar(context, noImplementation);
          },
          child: const Text(
            'Continue with Google',
            style: TextStyle(
              color: Pallete.blackColor,
              fontSize: AppTypography.fs16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  ConstrainedBox _createAccountButton(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: const BorderSide(width: 1.0, color: Pallete.blackColor),
            ),
            shadowColor: Pallete.blackColor,
            backgroundColor: Pallete.blackColor,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              register,
            );
          },
          child: const Text(
            'Create account',
            style: TextStyle(
              color: Pallete.whiteColor,
              fontSize: AppTypography.fs16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Row _seperator() {
    return Row(
      children: [
        Container(
          height: 1,
          width: 150,
          color: Pallete.greyColor,
        ),
        // Centered content
        const Expanded(
          child: Center(
            child: Text(
              'or',
              style: TextStyle(
                fontSize: AppTypography.fs16,
                color: Pallete.greyColor,
              ),
            ),
          ),
        ),
        // Right line
        Container(
          height: 1,
          width: 150,
          color: Pallete.greyColor,
        ),
      ],
    );
  }
}
