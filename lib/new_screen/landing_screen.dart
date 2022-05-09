import 'package:flutter/material.dart';
import 'package:whats_up/new_screen/login_screen.dart';
import 'package:whats_up/utils/dimensions.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height45),
              Text(
                "Welcome To WhatsApp",
                style: TextStyle(
                    fontSize: Dimensions.font14 * 2,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal),
              ),
              SizedBox(height: Dimensions.screenHeight / 12),
              Image.asset(
                "assets/images/bg.png",
                color: Colors.greenAccent[700],
                height: Dimensions.screenHeight / 2,
                width: Dimensions.screenWidth / 1.1,
              ),
              SizedBox(height: Dimensions.screenHeight / 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: Dimensions.font17, color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Agree and Continue to accept the ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const TextSpan(
                        text: "WhatsApp term of service and privacy policy ",
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const LoginScreen()),
                      (route) => false);
                },
                child: SizedBox(
                  width: Dimensions.screenWidth - 110,
                  height: Dimensions.height45,
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    elevation: 8,
                    color: Colors.greenAccent[700],
                    child: Center(
                      child: Text(
                        "AGREE AND CONTINU",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.font18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
