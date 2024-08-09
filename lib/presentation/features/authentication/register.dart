import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/business_logic/blocs/authentication/auth_bloc.dart';
import 'package:morningstar/business_logic/blocs/authentication/auth_event.dart';
import 'package:morningstar/presentation/common/textfield/custom_text_form_field.dart';
import 'package:morningstar/presentation/theme/theme.dart';
import 'package:morningstar/presentation/theme/typography.dart';
import 'package:morningstar/data/models/authentication/register_model.dart';
import 'package:morningstar/presentation/utils/utils.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late ValueNotifier<bool> _obscureTextNotifier;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordInvalid = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureTextNotifier = ValueNotifier(true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _obscureTextNotifier.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email should not be empty';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    _isPasswordInvalid = false;
    if (value == null || value.isEmpty) {
      _isPasswordInvalid = true;
      return 'Password should not be empty';
    }
    if (value.length < 6) {
      _isPasswordInvalid = true;
      return 'Password should be at least 6 characters long';
    }
    return null;
  }

  void _toggleObscureText() {
    _obscureTextNotifier.value = !_obscureTextNotifier.value;
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final RegisterModel payload = RegisterModel(
        name: _nameController.value.text,
        username: _usernameController.value.text,
        email: _emailController.value.text,
        password: _passwordController.value.text,
      );
      BlocProvider.of<AuthBloc>(context).add(RegisterUser(payload, context));
    } else {
      showSnackBar(context, 'Please fix the errors in red before submitting.');
    }
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Text(
                "Create your account",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Pallete.blackColor,
                  fontSize: AppTypography.fs24,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextFormField(
                      controller: _nameController,
                      labelText: 'Name',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: _usernameController,
                      labelText: 'Enter username',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: 'Enter Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: _passwordController,
                      obscureText: _obscureTextNotifier.value,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      validator: _validatePassword,
                      suffixIcon: ValueListenableBuilder<bool>(
                        valueListenable: _obscureTextNotifier,
                        builder: (context, obscureText, child) {
                          return IconButton(
                            icon: Icon(
                              obscureText ? Icons.visibility : Icons.visibility_off,
                              color: _isPasswordInvalid ? Pallete.redColor : null,
                            ),
                            onPressed: _toggleObscureText,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Pallete.greyColor)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.blackColor,
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(width: 1.0, color: Pallete.greyColor),
                ),
                shadowColor: Pallete.whiteColor,
              ),
              onPressed: _onSubmit,
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
    );
  }
}