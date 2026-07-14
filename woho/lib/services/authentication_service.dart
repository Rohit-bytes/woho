import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          Get.offAll(() => Dashboard());
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

        // Save additional user data in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name.trim(),
          'email': email.trim(),
          'phone': phone.trim(),
          'bio': bio?.trim() ?? "",
          'photoUrl': '',
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
}
