import 'package:flutter/material.dart';
import 'package:whats_up/models/country_model.dart';
import 'package:whats_up/new_screen/country_page.dart';
import 'package:whats_up/new_screen/otp_screen.dart';
import 'package:whats_up/utils/dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  String countryName = 'jordan';
  String countryCode = '+962';

  void setCountryData(CountryModel model) {
    setState(() {
      countryName = model.name;
      countryCode = model.code;
    });
    Navigator.pop(context);
  }

  Future<void> showMyDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We will be verifying your phone number",
                  style: TextStyle(fontSize: Dimensions.font14),
                ),
                Text(
                  countryCode + " " + _controller.text,
                  style: TextStyle(
                      fontSize: Dimensions.font14, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Is this ok, or would you like to edit number? ",
                  style: TextStyle(fontSize: Dimensions.font13),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => OtpScreen(
                            countryCode: countryCode,
                            number: _controller.text)));
              },
              child: const Text("Ok"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Edit"),
            )
          ],
        );
      },
    );
  }

  Future<void> showMyErorrDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "There is no number you entered",
                  style: TextStyle(fontSize: Dimensions.font14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Enter your phone number",
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w700,
              fontSize: Dimensions.font18,
              wordSpacing: 1),
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          )
        ],
      ),
      body: SizedBox(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        child: Column(
          children: [
            Text(
              "whatsapp will send an sms message to verify your number",
              style: TextStyle(
                fontSize: Dimensions.font13,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "what's my number?",
              style: TextStyle(
                  fontSize: Dimensions.font12, color: Colors.cyan[800]),
            ),
            countryCard(),
            const SizedBox(height: 15),
            number(),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                if (_controller.text.isNotEmpty) {
                  showMyDialog();
                } else {
                  showMyErorrDialog();
                }
              },
              child: Container(
                color: Colors.tealAccent[400],
                height: Dimensions.height45,
                width: Dimensions.width15 * 4,
                child: const Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: Dimensions.screenWidth / 1.5,
      height: 38,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.teal, width: 1.8),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "+",
                  style: TextStyle(fontSize: Dimensions.font18),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  countryCode.substring(1),
                  style: TextStyle(fontSize: Dimensions.font16),
                ),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Container(
            width: Dimensions.screenWidth / 1.5 - 100,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.teal, width: 1.8),
              ),
            ),
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                  hintText: "phone number"),
            ),
          ),
        ],
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) =>
                    CountryPage(setCountryData: setCountryData)));
      },
      child: Container(
        width: Dimensions.screenWidth / 1.5,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.teal, width: 1.8),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                child: Center(
                  child: Text(
                    countryName,
                    style: TextStyle(fontSize: Dimensions.font16),
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
              size: Dimensions.iconSize13 * 2,
            )
          ],
        ),
      ),
    );
  }
}
