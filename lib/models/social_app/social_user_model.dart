class SocialUserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;
  bool? isEmailVerified;

  //constructor
  SocialUserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.isEmailVerified,
  });

  //named constructor
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  //toMap method
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
