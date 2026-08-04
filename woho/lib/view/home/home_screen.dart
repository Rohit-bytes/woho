import 'package:flutter/material.dart';
import 'package:get/get.dart' hide navigator;
import 'package:woho/core/colorpallete.dart';
import 'package:woho/core/widget/custom_appbar.dart';
import 'package:woho/core/widget/custom_backbutton.dart';
import 'package:woho/core/widget/custom_home_page_profiles.dart';
import 'package:woho/core/widget/customutils.dart';
import 'package:woho/services/stripe_service.dart';
import 'package:woho/viewmodel/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          // appBar: CustomAppbar(
          //   title: "Welcome ${homeController.userData?.name ?? ''}",
          //   centerTitle: false,
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //       child: CustomButton(
          //         height: 40,
          //         onTap: () {},
          //         radius: 50,
          //         icon: Icons.add,
          //         text: "Post",
          //         backgroundColor: ColorPalette.primary,
          //         borderWidth: 2,
          //         borderColor: ColorPalette.background,
          //       ),
          //     ),
          //   ],
          // ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(customutils().paddingspace),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [CustomHomePageProfiles()],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
