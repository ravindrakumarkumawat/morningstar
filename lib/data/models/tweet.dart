import 'dart:convert';

class Tweet {
  final String id;
  final String text;
  final String username;
  Tweet({
    required this.id,
    required this.text,
    required this.username,
  });

 

  Tweet copyWith({
    String? id,
    String? text,
    String? username,
  }) {
    return Tweet(
      id: id ?? this.id,
      text: text ?? this.text,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'username': username,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      id: map['id'] as String,
      text: map['text'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tweet.fromJson(String source) => Tweet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Tweet(id: $id, text: $text, username: $username)';

  @override
  bool operator ==(covariant Tweet other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.text == text &&
      other.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ username.hashCode;
}
