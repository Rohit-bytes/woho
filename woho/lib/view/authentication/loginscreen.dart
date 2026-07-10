import 'package:flutter/material.dart';
import 'package:woho/core/widget/custom_button.dart';
import 'package:woho/core/widget/custom_textfield.dart';
import 'package:woho/services/authentication_service.dart';
import 'package:woho/view/authentication/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xff6C63FF).withOpacity(.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(35),
                        ),
                        child: Image.asset("asset/woho_logo.png"),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                const Text(
                  "Welcome Back 👋",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Login to continue using WOHO.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  controller: email,
                  hintText: "Email",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: password,
                  hintText: "Password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xff6C63FF)),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                CustomButton(
                  title: "Login",
                  onTap: () {
                    if (email.text.isEmpty || password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all the fields"),
                        ),
                      );
                      return;
                    }
                    AuthenticationService().signin(
                      email.text,
                      password.text,
                      context,
                    );
                  },
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                const SizedBox(height: 25),

                SizedBox(
                  height: 56,
                  width: double.infinity,
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
                      "Continue with Google",
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
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                        );
                      },
                      child: const Text(
                        "Sign Up",
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
  }
}
