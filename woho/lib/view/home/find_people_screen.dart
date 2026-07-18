import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woho/core/colorpallete.dart';
import 'package:woho/core/widget/custom_appbar.dart';
import 'package:woho/core/widget/custom_textfield.dart';
import 'package:woho/core/widget/custom_userprofile_widget.dart';
import 'package:woho/core/widget/customutils.dart';
import 'package:woho/viewmodel/home_controller.dart';

class FindPeopleScreen extends StatelessWidget {
  const FindPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          appBar: CustomAppbar(title: "Search"),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: customutils().paddingspace,
            ),
            child: Column(
              children: [
                SizedBox(height: customutils().sizedboxheight),
                CustomTextField(
                  borderradius: 30,
                  hintText: "Find Woho's near you",
                  prefixIcon: (Icons.search),
                  controller: TextEditingController(),

                  // maxlength: 2,
                ),
                SizedBox(height: customutils().sizedboxheight),
                Expanded(
                  child: ListView.builder(
                    itemCount: homeController.usersList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomUserprofileWidget(
                          useremail: homeController.usersList[index].email,
                          userimage: homeController.usersList[index].photoUrl,
                          username: homeController.usersList[index].name,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
