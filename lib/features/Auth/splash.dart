import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningstar/features/Auth/login.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                "See what's happening in the world right now.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            _googleLoginButton(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _seperator(),
            ),
            const SizedBox(
              height: 10,
            ),
            _createAccountButton(),
            const SizedBox(height: 20,),
            const Text(
              'Terms and Conditions apply.',
              style: TextStyle(fontSize: 16,),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.none,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ConstrainedBox _googleLoginButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: const BorderSide(width: 1.0, color: Colors.grey)),
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            // Button 1 action
          },
          child: const Text(
            'Continue with Google',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  ConstrainedBox _createAccountButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: const BorderSide(width: 1.0, color: Colors.black)),
            shadowColor: Colors.black,
            backgroundColor: Colors.black,
          ),
          onPressed: () {
            // Button 2 action
          },
          child: const Text(
            'Create account',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
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
          color: Colors.black,
        ),
        // Centered content
        const Expanded(
          child: Center(
            child: Text(
              'or',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        // Right line
        Container(
          height: 1,
          width: 150,
          color: Colors.black,
        ),
      ],
    );
  }
}
