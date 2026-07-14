import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;
  final String? bio;
  final Timestamp? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
    required this.photoUrl,
    this.createdAt,
  });

  /// Convert Firestore -> Model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      bio: map['bio'] ?? '',
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      createdAt: map['createdAt'],
    );
  }

  /// Convert Model -> Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      ' bio': bio,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
    };
  }
}
