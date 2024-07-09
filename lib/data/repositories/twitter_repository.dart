import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:morningstar/data/models/tweet.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class TwitterRepository {
  static const String _authorizationEndpoint = 'https://api.twitter.com/oauth2/authorize';
  static const String _tokenEndpoint = 'https://api.twitter.com/oauth2/token';
  static const String _redirectUrl = 'your_redirect_url';
  static const String _clientId = 'your_client_id'; 
  static const String _clientSecret = 'your_client_secret';

  final oauth2.AuthorizationCodeGrant _grant = oauth2.AuthorizationCodeGrant(
    _clientId,
    Uri.parse(_authorizationEndpoint),
    Uri.parse(_tokenEndpoint),
    secret: _clientSecret,
  );
  oauth2.Client? _client;

  Future<void> authenticate(Uri authorizationUrl, Uri redirectUrl) async {
    // Exchange the authorization code for an access token
    final oauth2.Client client = await _grant.handleAuthorizationResponse({
      'code': authorizationUrl.queryParameters['code']!,
      'redirect_uri': redirectUrl.toString(),
    });

    _client = client;
  }

  Future<List<Tweet>> fetchTweets() async {
    final response = await _client!.get(Uri.parse('https://api.twitter.com/2/tweets'));
    final data = jsonDecode(response.body) as List;
    return data.map((tweet) => Tweet.fromJson(tweet)).toList();
  }

  Future<void> postTweet(String text) async {
    await _client!.post(
      Uri.parse('https://api.twitter.com/2/tweets'),
      body: jsonEncode({'status': text}),
    );
  }

}
