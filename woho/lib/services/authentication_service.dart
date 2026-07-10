import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void signin(String email, String password, BuildContext context) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print("Signed in successfully");
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
    required BuildContext context,
  }) async {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print("Signed up successfully");
        })
        .catchError((error) {
          print("Error signing up: $error");
          Get.snackbar(
            "Signup Failed",
            "${error.message}",
            snackPosition: SnackPosition.BOTTOM,
          );
        });

    User? user = _auth.currentUser;
    if (user != null) {
      user.updateDisplayName(name);
      user.updatePhoneNumber(phone as PhoneAuthCredential);
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar(
        "Success",
        "Account created successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
