import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woho/core/colorpallete.dart';
import 'package:woho/services/authentication_service.dart';
import 'package:woho/viewmodel/home_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              width: 280,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      homeController.userData?.name.toUpperCase() ??
                          'Profile'.toUpperCase(),
                      style: TextStyle(
                        color: ColorPalette.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.verified, color: Colors.blue, size: 20, fill: 1),
                ],
              ),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                AuthenticationService().logout();
              },
              child: Icon(Icons.logout_outlined, color: ColorPalette.primary),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 350,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: ColorPalette.primary.withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.emoji_emotions_rounded,
                      size: 200,
                      color: ColorPalette.primary,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "About".toUpperCase(),
                        style: TextStyle(
                          color: ColorPalette.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    homeController.userData?.bio ?? "No bio available.",
                    style: TextStyle(
                      color: ColorPalette.textindark,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
