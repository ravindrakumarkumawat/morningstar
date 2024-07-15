import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/constants/outline_input_border.dart';
import 'package:morningstar/data/models/authentication/register_model.dart';
import 'package:morningstar/data/repositories/auth_repository.dart';
import 'package:morningstar/features/authentication/password.dart';
import 'package:morningstar/routes/routes.dart';
import 'package:morningstar/theme/theme.dart';
import 'package:morningstar/theme/typography.dart';
import 'package:morningstar/utils/utils.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
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
        // title: const Text('Morningstar'),
        centerTitle: true,
        backgroundColor: Pallete.whiteColor,
        leading: IconButton(
          icon: const FaIcon(
              FontAwesomeIcons.xmark), // Replace with your desired icon
          onPressed: () {
            // Add your onPressed logic here
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
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Text(
                    "Create your account",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Pallete.blackColor,
                      fontSize: AppTypography.fs28,
                    ),
                    textAlign: TextAlign.start,
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
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
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
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Enter username',
                          // hintText: 'Email, Phone, or Username',
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
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Enter email',
                          // hintText: 'Email, Phone, or Username',
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
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PasswordField(
                          textEditingController: _passwordController),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.blackColor,
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                          width: 1.0, color: Pallete.greyColor)),
                  shadowColor: Pallete.whiteColor,
                ),
                onPressed: () async {
                  print(_nameController);
                  print(_usernameController);
                  print(_emailController);
                  print(_passwordController);

                  final RegisterModel payload = RegisterModel(
                    name: _nameController.value.text,
                    username: _usernameController.value.text,
                    email: _emailController.value.text,
                    password: _passwordController.value.text,
                  );
                  if (payload.email.isNotEmpty && payload.password.isNotEmpty) {
                    // TODO: VALIDATION NEEDS TO BE HANDLED AROUND EMAIL AND PASSWORD
                    // await AuthRepository().authenticate(payload);
                    await AuthRepository()
                        .registerUserWithEmailAndPassword(payload, context);
                  } else {
                    showSnackBar(
                        context, 'Email or password should not be empty',);
                  }
                  // // if (_formKey.currentState.validate()) {
                  // if (true) {
                  //   // Valid input, proceed with your logic
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Valid Input')),
                  //   );
                  // } else {
                  //   // Invalid input
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Invalid Input')),
                  //   );
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
