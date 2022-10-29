class SocialUserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerified;

  //constructor
  SocialUserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.image,
    this.bio,
    this.cover,
    this.isEmailVerified,
  });

  //named constructor
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  //toMap method
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'image': image,
      'bio': bio,
      'cover': cover,
      'isEmailVerified': isEmailVerified,
    };
  }
}
