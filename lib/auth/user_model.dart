class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profileImage;
  final bool isVerified;
  final String fcmToken;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.isVerified,
    required this.fcmToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name']?.isNotEmpty == true ? map['name'] : 'Unknown',
      email: map['email']?.isNotEmpty == true ? map['email'] : 'non@caol.co',
      profileImage: map['profileImage'] ?? '',
      isVerified: map['isVerified'] ?? false,
      fcmToken: map['fcmToken'] ?? '',
    );
  }
}
