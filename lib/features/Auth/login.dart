import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const FaIcon(FontAwesomeIcons.xTwitter),
        // title: const Text('Morningstar'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Text('Forgot password?'),
          ],
        ),
      ),
    );
  }
}
