class Register {
  String? id;
  String? uid;
  String? name;
  String? username;
  String? email;
  String? mobile;
  String? country;
  String? countryCode;
  String? password;

  Register(
      {this.id,
      this.uid,
      this.name,
      this.username,
      this.email,
      this.mobile,
      this.country,
      this.countryCode,
      this.password});

  Register.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    country = json['country'];
    countryCode = json['countryCode'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobile;
    data['country'] = country;
    data['countryCode'] = countryCode;
    data['password'] = password;
    return data;
  }
}
