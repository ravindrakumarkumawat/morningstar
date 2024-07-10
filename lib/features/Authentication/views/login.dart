import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/constants/outline_input_border.dart';
import 'package:morningstar/features/accounts/accounts_list.dart';
import 'package:morningstar/features/authentication/password.dart';
import 'package:morningstar/routes/routes.dart';
import 'package:morningstar/theme/theme.dart';
import 'package:morningstar/theme/typography.dart';
import 'package:morningstar/utils/utils.dart';
import 'package:morningstar/data/models/authentication/login_model.dart';
import 'package:morningstar/data/repositories/auth_repository.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String validateInput(String value) {
    // if (value.isEmpty) {
    //   return 'Please enter a value';
    // // } else if (EmailValidator.validate(value)) {
    //   // return null; // Valid email
    // } else if (value.length == 10 && int.tryParse(value) != null) {
    //   // return null; // Valid phone number
    // } else {
    //   // Custom username validation, for example: only alphanumeric and underscores
    //   RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    //   if (usernameRegExp.hasMatch(value)) {
    //     // return null; // Valid username
    //   } else {
    //     return 'Invalid format';
    //   }
    // }
    return '';
  }

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
                      side: const BorderSide(
                          width: 1.0, color: Pallete.blueColor)),
                  shadowColor: Pallete.whiteColor,
                ),
                onPressed: () async {
                  final LoginModel payload = LoginModel(
                    email: textController.value.text,
                    password: _passwordController.value.text,
                  );
                  if(payload.email.isNotEmpty && payload.password.isNotEmpty) {
                    // TODO: VALIDATION NEEDS TO BE HANDLED AROUND EMAIL AND PASSWORD
                    await AuthRepository().login(payload);
                    if (context.mounted) {
                      Navigator.pushNamed(
                        context,
                        home,
                      );
                    }
                  } else {
                    showSnackBar(context, 'Email or password should not be empty');
                  }
                  
                  // if (_formKey.currentState.validate()) {
                  // if (true) {
                  // Valid input, proceed with your logic
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Valid Input')),
                  // );
                  

                  // } else {
                  //   showSnackBar(context, 'Invalid Input');
                  // }
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
