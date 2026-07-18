import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:woho/model/user_model.dart';
import 'package:woho/view/authentication/loginscreen.dart';
import 'package:woho/view/home/dashboard.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void userexist() {
    User? user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => Dashboard());
    } else {
      // User is not signed in, navigate to the login screen
      Get.offAll(() => LoginScreen());
    }
  }

  void logout() {
    User? user = _auth.currentUser;
    if (user != null) {
      _auth
          .signOut()
          .then((_) {
            Get.offAll(() => LoginScreen());
          })
          .catchError((error) {
            print("Error signing out: $error");
            Get.snackbar(
              "Logout Failed",
              "${error.message}",
              snackPosition: SnackPosition.BOTTOM,
            );
          });
    } else {
      // User is not signed in, navigate to the login screen
      Get.offAll(() => LoginScreen());
    }
  }

  Future<UserModel?> userData() async {
    User? user = _auth.currentUser;

    if (user == null) return null;

    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }

    return null;
  }

  void signin(String email, String password, BuildContext context) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print("Signed in successfully");
          Get.to(() => Dashboard());
        })
        .catchError((error) {
          print("Error signing in: $error");
          Get.snackbar(
            "Login Failed",
            "${error.message}",
            snackPosition: SnackPosition.BOTTOM,
          );
        });
  }

  Future<void> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    File? profileImage,
    String? bio,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = credential.user;

      if (user != null) {
        // Save display name in Firebase Auth
        await user.updateDisplayName(name);
        String photoUrl = '';

        // Upload image to Cloudinary if user selected one
        if (profileImage != null) {
          print("Uploading profile image...");

          final uploadedUrl = await uploadImageToCloudinary(profileImage);

          if (uploadedUrl != null) {
            photoUrl = uploadedUrl;
            print("Image uploaded successfully: $photoUrl");
          } else {
            print("Image upload failed");
          }
        }

        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name.trim(),
          'email': email.trim(),
          'phone': phone.trim(),
          'bio': bio?.trim() ?? "",
          'photoUrl': photoUrl,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.snackbar(
          "Success",
          "Account created successfully",
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAll(() => Dashboard());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Signup Failed",
        e.message ?? "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      print("Error signing up: $e");
    }
  }

  Future<String?> uploadImageToCloudinary(File imageFile) async {
    const cloudName = 'v99u8jdt'; // verify/copy exact value from dashboard
    const uploadPreset = 'woho_profile_images';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', url);

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);

      return data['secure_url'];
    } else {
      final error = await response.stream.bytesToString();
      print('Cloudinary upload failed: $error');
      return null;
    }
  }
}
