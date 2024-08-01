import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/presentation/common/button/custom_flat_button.dart';
import 'package:morningstar/presentation/constants/custom_widgets.dart';
import 'package:morningstar/presentation/constants/outline_input_border.dart';
import 'package:morningstar/presentation/theme/pallete.dart';
import 'package:morningstar/presentation/utils/utils.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPassword> {
  late FocusNode _focusNode;
  late TextEditingController _emailController;
  @override
  void initState() {
    _focusNode = FocusNode();
    _emailController = TextEditingController();
    _emailController.text = '';
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _label(),
            const SizedBox(
              height: 50,
            ),
            _entryField('Enter email', controller: _emailController),
            // SizedBox(height: 10,),
            _submitButton(context),
          ],
        ));
  }

  Widget _entryField(String hint,
      {required TextEditingController controller, bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        focusNode: _focusNode,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
            fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: BorderState.border,
          enabledBorder: BorderState.enabledBorder,
          focusedBorder: BorderState.focusedBorder,
          errorBorder: BorderState.errorBorder,
          focusedErrorBorder: BorderState.focusedErrorBorder,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      child: CustomFlatButton(
        label: "Submit",
        onPressed: _submit,
        borderRadius: 8,
      ),
    );
  }

  Widget _label() {
    return Container(
        child: Column(
      children: <Widget>[
        customText('Forget Password',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: customText(
              'Enter your email address below to receive password reset instruction',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
              textAlign: TextAlign.center),
        )
      ],
    ));
  }

  void _submit() {
    if (_emailController.text.isEmpty) {
      showSnackBar(context, 'Email field cannot be empty');
      return;
    }
    var isValidEmail = validateEmail(
      _emailController.text,
    );
    if (!isValidEmail) {
      showSnackBar(context, 'Please enter valid email address');
      return;
    }

    _focusNode.unfocus();
    // var state = Provider.of<AuthState>(context, listen: false);
    // state.forgetPassword(_emailController.text, context: context);
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
      body: _body(context),
    );
  }
}
