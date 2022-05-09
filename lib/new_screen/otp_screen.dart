import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:whats_up/utils/dimensions.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  final String countryCode;
  const OtpScreen({Key? key, required this.number, required this.countryCode})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Verify ${widget.countryCode} ${widget.number}",
          style:
              TextStyle(color: Colors.teal[800], fontSize: Dimensions.font16),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "We have sent an SMS with a code to ",
                    style: TextStyle(
                        color: Colors.black, fontSize: Dimensions.font14),
                  ),
                  TextSpan(
                    text: widget.countryCode + " " + widget.number,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " Wrong number?",
                    style: TextStyle(
                      color: Colors.cyan[800],
                      fontSize: Dimensions.font14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            const SizedBox(height: 10),
            Text(
              "Enter 6-digit code",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: Dimensions.font14,
              ),
            ),
            const SizedBox(height: 30),
            bottumBotton(Icons.message, "Resend SMS"),
            const SizedBox(height: 12),
            const Divider(thickness: 1.5),
            const SizedBox(height: 12),
            bottumBotton(Icons.call, "Call Me"),
          ],
        ),
      ),
    );
  }

  Widget bottumBotton(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.teal,
          size: Dimensions.iconSize24,
        ),
        SizedBox(width: Dimensions.width10),
        Text(
          text,
          style: TextStyle(
            color: Colors.teal,
            fontSize: Dimensions.font14,
          ),
        )
      ],
    );
  }
}
