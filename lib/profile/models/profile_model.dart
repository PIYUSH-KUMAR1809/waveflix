// To parse this JSON data, do
//
//     final userProfile = userProfileFromMap(jsonString);

import 'dart:convert';

UserProfile userProfileFromMap(String str) =>
    UserProfile.fromMap(json.decode(str));

String userProfileToMap(UserProfile data) => json.encode(data.toMap());

class UserProfile {
  int id;
  DateTime createdAt;
  String name;
  String email;
  String phone;
  String imageUrl;
  String uid;

  UserProfile({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.uid,
  });

  factory UserProfile.fromMap(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        imageUrl: json["image_url"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "email": email,
        "phone": phone,
        "image_url": imageUrl,
        "uid": uid,
      };
}
