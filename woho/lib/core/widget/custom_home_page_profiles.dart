import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woho/core/colorpallete.dart';
import 'package:woho/viewmodel/home_controller.dart';

class CustomHomePageProfiles extends StatelessWidget {
  const CustomHomePageProfiles({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homecontroller) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homecontroller.userProfileData?.results.length ?? 0,
          itemBuilder: (context, index) {
            final userProfile = homecontroller.userProfileData?.results[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () => Get.toNamed('/profile', arguments: userProfile),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              homecontroller.loadUserData == ""
                                  ? CircularProgressIndicator()
                                  : Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          child: Image.network(
                                            userProfile!.picture.large ?? "",
                                            height: 50,
                                            width: 50,
                                            fit:
                                                homecontroller
                                                        .userData
                                                        ?.photoUrl !=
                                                    null
                                                ? BoxFit.cover
                                                : BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${userProfile!.name.first} ${userProfile!.name.last}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),

                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.alternate_email,
                                                  size: 12,
                                                  color:
                                                      ColorPalette.textindark,
                                                ),
                                                Text(
                                                  " ${userProfile!.email ?? ''}",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                              Icon(
                                Icons.verified,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Image.network(
                            height: 500,
                            width: double.infinity,
                            userProfile!.picture.large ?? '',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
