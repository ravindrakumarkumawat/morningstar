// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TweetModel {
  String? id;
  String? tweetedAt;
  String? avatar;
  String? name;
  String? username;
  String? text;
  List<String>? imageLinks;
  String? tweetType;
  String? link;
  List<String>? commentIds;
  int? reshareCount;
  List<String>? likes;
  String? retweetedBy;
  String? repliedTo;
  TweetModel({
    this.id,
    this.tweetedAt,
    this.avatar,
    this.name,
    this.username,
    this.text,
    this.imageLinks,
    this.tweetType,
    this.link,
    this.commentIds,
    this.reshareCount,
    this.likes,
    this.retweetedBy,
    this.repliedTo,
  });


  TweetModel copyWith({
    String? id,
    String? tweetedAt,
    String? avatar,
    String? name,
    String? username,
    String? text,
    List<String>? imageLinks,
    String? tweetType,
    String? link,
    List<String>? commentIds,
    int? reshareCount,
    List<String>? likes,
    String? retweetedBy,
    String? repliedTo,
  }) {
    return TweetModel(
      id: id ?? this.id,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      username: username ?? this.username,
      text: text ?? this.text,
      imageLinks: imageLinks ?? this.imageLinks,
      tweetType: tweetType ?? this.tweetType,
      link: link ?? this.link,
      commentIds: commentIds ?? this.commentIds,
      reshareCount: reshareCount ?? this.reshareCount,
      likes: likes ?? this.likes,
      retweetedBy: retweetedBy ?? this.retweetedBy,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tweetedAt': tweetedAt,
      'avatar': avatar,
      'name': name,
      'username': username,
      'text': text,
      'imageLinks': imageLinks,
      'tweetType': tweetType,
      'link': link,
      'commentIds': commentIds,
      'reshareCount': reshareCount,
      'likes': likes,
      'retweetedBy': retweetedBy,
      'repliedTo': repliedTo,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      id: map['id'] != null ? map['id'] as String : null,
      tweetedAt: map['tweetedAt'] != null ? map['tweetedAt'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      imageLinks: map['imageLinks'] != null ? List<String>.from((map['imageLinks'] as List<String>)) : null,
      tweetType: map['tweetType'] != null ? map['tweetType'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      commentIds: map['commentIds'] != null ? List<String>.from((map['commentIds'] as List<String>)) : null,
      reshareCount: map['reshareCount'] != null ? map['reshareCount'] as int : null,
      likes: map['likes'] != null ? List<String>.from((map['likes'] as List<String>)) : null,
      retweetedBy: map['retweetedBy'] != null ? map['retweetedBy'] as String : null,
      repliedTo: map['repliedTo'] != null ? map['repliedTo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModel.fromJson(String source) => TweetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TweetModel(id: $id, tweetedAt: $tweetedAt, avatar: $avatar, name: $name, username: $username, text: $text, imageLinks: $imageLinks, tweetType: $tweetType, link: $link, commentIds: $commentIds, reshareCount: $reshareCount, likes: $likes, retweetedBy: $retweetedBy, repliedTo: $repliedTo)';
  }

  @override
  bool operator ==(covariant TweetModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.tweetedAt == tweetedAt &&
      other.avatar == avatar &&
      other.name == name &&
      other.username == username &&
      other.text == text &&
      listEquals(other.imageLinks, imageLinks) &&
      other.tweetType == tweetType &&
      other.link == link &&
      listEquals(other.commentIds, commentIds) &&
      other.reshareCount == reshareCount &&
      listEquals(other.likes, likes) &&
      other.retweetedBy == retweetedBy &&
      other.repliedTo == repliedTo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      tweetedAt.hashCode ^
      avatar.hashCode ^
      name.hashCode ^
      username.hashCode ^
      text.hashCode ^
      imageLinks.hashCode ^
      tweetType.hashCode ^
      link.hashCode ^
      commentIds.hashCode ^
      reshareCount.hashCode ^
      likes.hashCode ^
      retweetedBy.hashCode ^
      repliedTo.hashCode;
  }
}
