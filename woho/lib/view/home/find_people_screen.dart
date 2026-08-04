import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woho/core/colorpallete.dart';
import 'package:woho/core/widget/custom_appbar.dart';
import 'package:woho/core/widget/custom_suggestion_users.dart';
import 'package:woho/core/widget/custom_textfield.dart';
import 'package:woho/core/widget/custom_titletrack.dart';
import 'package:woho/core/widget/custom_userprofile_widget.dart';
import 'package:woho/core/widget/customutils.dart';
import 'package:woho/view/home/other_user_profile.dart';
import 'package:woho/viewmodel/home_controller.dart';

class FindPeopleScreen extends StatelessWidget {
  const FindPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          // appBar: CustomAppbar(title: "Search"),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
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
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CustomSectionTitle(
                          title: "Woho's Suggestions",
                          icon: Icons.person,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 210,
                      // width: 210,
                      child: PageView.builder(
                        padEnds: false,
                        controller: PageController(viewportFraction: 0.50),

                        // allowImplicitScrolling: true,
                        itemCount: homeController.usersList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.to(
                              () => OtherUserProfileScreen(
                                uuid: homeController.usersList[index].uid,
                                userEmail:
                                    homeController.usersList[index].email,
                                userImage:
                                    homeController.usersList[index].photoUrl,
                                userName: homeController.usersList[index].name,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: SuggestionUserWidget(
                                useruuid: homeController.usersList[index].uid,
                                userimage:
                                    homeController.usersList[index].photoUrl,
                                username: homeController.usersList[index].name,
                                useremail:
                                    homeController.usersList[index].email,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: customutils().sizedboxheight),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeController.usersList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => Get.to(
                              () => OtherUserProfileScreen(
                                uuid: homeController.usersList[index].uid,
                                userEmail:
                                    homeController.usersList[index].email,
                                userImage:
                                    homeController.usersList[index].photoUrl,
                                userName: homeController.usersList[index].name,
                              ),
                            ),
                            child: CustomUserprofileWidget(
                              useremail: homeController.usersList[index].email,
                              userimage:
                                  homeController.usersList[index].photoUrl,
                              username: homeController.usersList[index].name,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
