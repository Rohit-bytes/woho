import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woho/view/home/find_people_screen.dart';
import 'package:woho/view/home/home_screen.dart';
import 'package:woho/view/home/profile_screen.dart';
import 'package:woho/viewmodel/home_controller.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          body: homeController.screens[homeController.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            iconSize: homeController.selectedIndex == 0 ? 30 : 24,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              homeController.onItemTapped(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
