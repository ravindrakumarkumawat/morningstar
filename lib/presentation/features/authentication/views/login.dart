import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/business_logic/blocs/authentication/auth_bloc.dart';
import 'package:morningstar/business_logic/blocs/authentication/auth_event.dart';
import 'package:morningstar/presentation/constants/outline_input_border.dart';
import 'package:morningstar/data/models/authentication/login_model.dart';
import 'package:morningstar/presentation/features/authentication/password.dart';
import 'package:morningstar/presentation/theme/theme.dart';
import 'package:morningstar/presentation/theme/typography.dart';
import 'package:morningstar/presentation/utils/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      appBar: AppBar(
        title: const FaIcon(FontAwesomeIcons.xTwitter),
        centerTitle: true,
        backgroundColor: Pallete.whiteColor,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Text(
                  // "To get started, first enter your phone, email, or @username",
                  "To get started, first enter your email",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Pallete.blackColor,
                    fontSize: AppTypography.fs24,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          // labelText: 'Enter Email, Phone, or Username',
                          labelText: 'Enter Email',
                          labelStyle: const TextStyle(
                            color: Pallete.blackColor,
                          ),
                          border: BorderState.border,
                          enabledBorder: BorderState.enabledBorder,
                          focusedBorder: BorderState.focusedBorder,
                          errorBorder: BorderState.errorBorder,
                          focusedErrorBorder: BorderState.focusedErrorBorder,
                        ),
                        keyboardType: TextInputType.text,
                        // validator: validateInput,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PasswordField(
                          textEditingController: _passwordController),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Pallete.greyColor))),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.whiteColor,
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                          width: 1.0, color: Pallete.greyColor)),
                  shadowColor: Pallete.whiteColor,
                ),
                onPressed: () {
                  showSnackBar(context, noImplementation);
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Pallete.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: AppTypography.fs16,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.blackColor,
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side:
                        const BorderSide(width: 1.0, color: Pallete.blackColor),
                  ),
                  shadowColor: Pallete.whiteColor,
                ),
                onPressed: () async {
                  final LoginModel payload = LoginModel(
                    email: textController.value.text,
                    password: _passwordController.value.text,
                  );
                  if (payload.email.isNotEmpty && payload.password.isNotEmpty) {
                    BlocProvider.of<AuthBloc>(context).add(
                      LogInUser(payload, context),
                    );
                  } else {
                    showSnackBar(
                        context, 'Email or password should not be empty');
                  }
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontWeight: FontWeight.w600,
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
}