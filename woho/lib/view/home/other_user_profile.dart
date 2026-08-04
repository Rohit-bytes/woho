import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woho/core/colorpallete.dart';
import 'package:woho/core/widget/custom_appbar.dart';
import 'package:woho/core/widget/custom_backbutton.dart';
import 'package:woho/core/widget/custom_userprofile_widget.dart';
import 'package:woho/core/widget/customutils.dart';
import 'package:woho/services/authentication_service.dart';
import 'package:woho/view/home/dashboard.dart';
import 'package:woho/view/home/home_screen.dart';
import 'package:woho/view/home/profile_screen.dart';
import 'package:woho/viewmodel/home_controller.dart';

class OtherUserProfileScreen extends StatefulWidget {
  final String? userEmail;
  final String? userImage;
  final String? userName;
  final String? uuid;
  const OtherUserProfileScreen({
    super.key,
    required this.userEmail,
    required this.userImage,
    required this.userName,
    required this.uuid,
  });

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        // final user = homeController.userProfileData!.results.firstWhere(
        //   (e) => e.uuid == uuid;
        // );
        return Scaffold(
          // appBar: CustomAppbar(
          //   title: "Profile",
          //   actions: [
          //     IconButton(
          //       splashRadius: 22,
          //       onPressed: () {
          //         AuthenticationService().logout();
          //       },
          //       icon: Icon(
          //         Icons.logout_rounded,
          //         color: ColorPalette.background,
          //       ),
          //     ),
          //   ],
          // ),
          body: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(customutils().paddingspace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBackButton(
                        onTap: () {
                          if (Get.key.currentState?.canPop() ?? false) {
                            Get.back();
                          } else {
                            Get.offAll(() => Dashboard());
                          }
                        },
                        icon: Icons.arrow_back_ios,
                      ),
                      SizedBox(height: customutils().sizedboxheight),

                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: double.infinity,
                          height: 370,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: ColorPalette.primary.withOpacity(0.15),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),

                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Image
                                if (widget.userImage != null &&
                                    widget.userImage!.isNotEmpty)
                                  Image.network(
                                    widget.userImage ?? "",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return _defaultProfile();
                                    },
                                  )
                                else
                                  _defaultProfile(),

                                // Bottom gradient
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.65),
                                      ],
                                    ),
                                  ),
                                ),

                                // Profile name
                                Positioned(
                                  left: 20,
                                  right: 20,
                                  bottom: 20,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.userName ?? "Woho User",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 27,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: -0.7,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.verified,
                                          color: Colors.blue,
                                          size: 19,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: customutils().sizedboxheight * 1.5),

                      // ==============================
                      // EMAIL HEADER
                      // ==============================
                      _sectionTitle(
                        title: "EMAIL",
                        icon: Icons.auto_awesome_rounded,
                      ),

                      const SizedBox(height: 12),

                      // ==============================
                      // BIO CARD
                      // ==============================
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: ColorPalette.primary.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: ColorPalette.primary.withOpacity(0.12),
                          ),
                        ),
                        child: Text(
                          widget.userEmail ?? "No email provided",
                          style: TextStyle(
                            color: ColorPalette.textindark,
                            fontSize: 15,
                            height: 1.6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(height: customutils().sizedboxheight * 2),

                      // ==============================
                      // DISCOVER HEADER
                      // ==============================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _sectionTitle(
                            title: "FOLLOW MORE WOHO'S",
                            icon: Icons.people_alt_rounded,
                          ),

                          // Swipe indicator
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 6),
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(value, 0),
                                child: child,
                              );
                            },
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: ColorPalette.primary,
                              size: 20,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Find your vibe. Follow your people ✨",
                        style: TextStyle(
                          color: ColorPalette.textindark.withOpacity(0.6),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // ==============================
                      // HORIZONTAL USERS
                      // ==============================
                      SizedBox(
                        height: 120,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.92),
                          physics: const BouncingScrollPhysics(),
                          padEnds: false,
                          itemCount: homeController.usersList.length,
                          itemBuilder: (context, index) {
                            final user = homeController.usersList[index];

                            return GestureDetector(
                              onTap: () => Get.offAll(
                                () => OtherUserProfileScreen(
                                  uuid: user.uid,
                                  userEmail: user.email,
                                  userImage: user.photoUrl,
                                  userName: user.name,
                                ),
                              ),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.9, end: 1),
                                duration: Duration(
                                  milliseconds: 400 + (index * 100),
                                ),
                                curve: Curves.easeOutBack,
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    alignment: Alignment.centerLeft,
                                    child: child,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: CustomUserprofileWidget(
                                    isHorizontal: true,
                                    useremail: user.email,
                                    userimage: user.photoUrl,
                                    username: user.name,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ==============================
  // SECTION TITLE
  // ==============================

  Widget _sectionTitle({required String title, required IconData icon}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: ColorPalette.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, color: ColorPalette.primary, size: 16),
        ),

        const SizedBox(width: 9),

        Text(
          title,
          style: TextStyle(
            color: ColorPalette.primary,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }

  // ==============================
  // DEFAULT PROFILE
  // ==============================

  Widget _defaultProfile() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorPalette.primary,
            ColorPalette.primary.withOpacity(0.65),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.emoji_emotions_rounded,
          size: 130,
          color: Colors.white24,
        ),
      ),
    );
  }
}
