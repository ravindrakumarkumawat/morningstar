class Token {
  String? authToken;

  Token({this.authToken});

  Token.fromJson(Map<String, dynamic> json) {
    authToken = json['authToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authToken'] = authToken;
    return data;
  }
}
