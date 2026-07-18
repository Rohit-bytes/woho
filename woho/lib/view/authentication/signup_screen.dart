import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woho/core/widget/custom_button.dart';
import 'package:woho/core/widget/custom_textfield.dart';
import 'package:woho/services/authentication_service.dart';
import 'package:woho/viewmodel/home_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final name = TextEditingController();
  final email = TextEditingController();
  final bio = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: const Color(0xff6C63FF).withOpacity(.1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Image.asset(
                            "asset/woho_logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      "Create Account 🚀",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Join WOHO and start sharing moments.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),

                    const SizedBox(height: 35),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: name,
                                hintText: "Full Name",
                                prefixIcon: Icons.person_outline,
                              ),

                              const SizedBox(height: 18),
                              CustomTextField(
                                controller: bio,
                                hintText: "Bio",
                                prefixIcon: Icons.info_outline,
                                maxlength: 150,
                                showCounter: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              // Handle profile picture selection
                              Get.find<HomeController>().openCamera();
                            },
                            child: Container(
                              width: 120,
                              height: 120,
                              child: homeController.profileImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(28),
                                      child: Image.file(
                                        homeController.profileImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.emoji_emotions_rounded,
                                      size: 80,
                                      color: Colors.grey.shade400,
                                    ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color(0xff6C63FF).withOpacity(.1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    CustomTextField(
                      controller: email,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 18),

                    CustomTextField(
                      isPhoneNumber: true,
                      controller: phone,
                      hintText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone_outlined,
                    ),

                    const SizedBox(height: 18),

                    CustomTextField(
                      controller: password,
                      hintText: "Password",
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),

                    const SizedBox(height: 18),

                    CustomTextField(
                      controller: confirmPassword,
                      hintText: "Confirm Password",
                      prefixIcon: Icons.lock_reset_outlined,
                      obscureText: true,
                    ),

                    const SizedBox(height: 30),

                    CustomButton(
                      title: "Create Account",
                      onTap: () {
                        if (name.text.isEmpty ||
                            email.text.isEmpty ||
                            phone.text.isEmpty ||
                            password.text.isEmpty ||
                            confirmPassword.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill all the fields"),
                            ),
                          );
                          return;
                        }
                        if (password.text.trim() !=
                            confirmPassword.text.trim()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match"),
                            ),
                          );
                          return;
                        }
                        if (email.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter your email address"),
                            ),
                          );
                          return;
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

                        if (!emailRegex.hasMatch(email.text.trim())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please enter a valid email address",
                              ),
                            ),
                          );
                          return;
                        }
                        if (password.text.trim().length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Password should be at least 6 characters long",
                              ),
                            ),
                          );
                          return;
                        }
                        if (homeController.profileImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please upload a profile image"),
                            ),
                          );
                          return;
                        }
                        AuthenticationService().signup(
                          name: name.text.trim(),
                          email: email.text.trim(),
                          phone: phone.text.trim(),
                          bio: bio.text.trim(),
                          password: password.text.trim(),
                          profileImage: homeController.profileImage,
                        );
                      },
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "asset/icons/google_logo.jpg",
                            height: 24,
                          ),
                        ),
                        label: const Text(
                          "Sign up with Google",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),

                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xff6C63FF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
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
