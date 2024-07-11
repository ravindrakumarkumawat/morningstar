// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterModel {
  final String? id;
  final String? uid;
  final String name;
  final String username;
  final String email;
  final String? mobile;
  final String? country;
  final String? countryCode;
  final String password;
  RegisterModel({
    this.id,
    this.uid,
    required this.name,
    required this.username,
    required this.email,
    this.mobile,
    this.country,
    this.countryCode,
    required this.password,
  });


  RegisterModel copyWith({
    String? id,
    String? uid,
    String? name,
    String? username,
    String? email,
    String? mobile,
    String? country,
    String? countryCode,
    String? password,
  }) {
    return RegisterModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'name': name,
      'username': username,
      'email': email,
      'mobile': mobile,
      'country': country,
      'countryCode': countryCode,
      'password': password,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      id: map['id'] != null ? map['id'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      countryCode: map['countryCode'] != null ? map['countryCode'] as String : null,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) => RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterModel(id: $id, uid: $uid, name: $name, username: $username, email: $email, mobile: $mobile, country: $country, countryCode: $countryCode, password: $password)';
  }

  @override
  bool operator ==(covariant RegisterModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.uid == uid &&
      other.name == name &&
      other.username == username &&
      other.email == email &&
      other.mobile == mobile &&
      other.country == country &&
      other.countryCode == countryCode &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uid.hashCode ^
      name.hashCode ^
      username.hashCode ^
      email.hashCode ^
      mobile.hashCode ^
      country.hashCode ^
      countryCode.hashCode ^
      password.hashCode;
  }
}
