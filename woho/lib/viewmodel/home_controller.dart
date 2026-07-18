import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woho/model/user_model.dart';
import 'package:woho/services/authentication_service.dart';
import 'package:woho/view/home/find_people_screen.dart';
import 'package:woho/view/home/home_screen.dart';
import 'package:woho/view/home/profile_screen.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;
  UserModel? userData;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    allUser();
  }

  final List<Widget> screens = const [
    HomeScreen(),
    FindPeopleScreen(),
    ProfileScreen(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    update(); // Notify listeners to rebuild the UI
  }

  //data for edit screen
  void loadUserData() async {
    userData = await AuthenticationService().userData();
    print("User Data: $userData");
    update();
  }

  File? profileImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> openCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      profileImage = File(image.path);
      update();
    }
  }

  List<UserModel> usersList = [];

  Future<void> allUser() async {
    try {
      final userdata = await AuthenticationService().listOfUsers();

      usersList = userdata;

      print("All users list: $usersList");

      update();
    } catch (e) {
      print("Error fetching users: $e");
    }
  }
}
