import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woho/view/home/find_people_screen.dart';
import 'package:woho/view/home/home_screen.dart';
import 'package:woho/view/home/profile_screen.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    FindPeopleScreen(),
    ProfileScreen(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    update(); // Notify listeners to rebuild the UI
  }
}
