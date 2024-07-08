import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:morningstar/blocs/authentication_bloc/authentication_event.dart';
import 'package:morningstar/blocs/authentication_bloc/authentication_state.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Twitter Authentication')),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccessState) {
            Navigator.pushReplacementNamed(context, '/tweets');
          } else if (state is AuthenticationFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final grant = oauth2.AuthorizationCodeGrant(
                    'your_client_id',
                    Uri.parse('https://api.twitter.com/oauth2/authorize'),
                    Uri.parse('https://api.twitter.com/oauth2/token'),
                    secret: 'your_client_secret',
                  );
                  final authorizationUrl = grant.getAuthorizationUrl(
                    Uri.parse('your_redirect_url'),
                  );

                  // Open the authorization URL in the browser
                  // After user authorizes the app, get the authorization code and redirect URL

                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationSuccessEvent(
                      authorizationUrl: authorizationUrl,
                      redirectUrl: Uri.parse('your_redirect_url'),
                    ),
                  );
                },
                child: Text('Authenticate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
