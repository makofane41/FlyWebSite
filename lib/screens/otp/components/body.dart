// Body.dart
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flybuy/screens/sign_in/sign_in_screen.dart';

import './otp_form.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';

class Body extends StatelessWidget {
  final String email;

  Body(this.email);

  void verifyOTP(String otp) async {
    final url = Uri.parse('https://prod-api.hustleshub.com/user/verifyotp');
    final response = await http.post(url, body: {'otp': otp});

    if (response.statusCode == 200) {
      // OTP verification successful
      Fluttertoast.showToast(
        msg: "OTP verification successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      // OTP verification failed
      Fluttertoast.showToast(
        msg: "OTP verification failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(25),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Text("OTP Verification", style: headingStyle),
                Text(
                  "We sent your code to $email",
                  textAlign: TextAlign.center,
                ),
                buildTimer(),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                OtpForm(onPinEntered: verifyOTP),
                SizedBox(height: SizeConfig.screenHeight * 0.15),
                DefaultButton(
                  text: "Verify OTP",
                  press: () {
                    // The OTP entered in the form will be verified
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.2),
                TextButton(
                  onPressed: () {
                    // Resend OTP code
                  },
                  child: Text(
                    "Resend OTP Code",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expire in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 300.0, end: 0.00),
          duration: Duration(seconds: 300),
          builder: (context, value, child) => Text(
            "${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {},
        ),
      ],
    );
  }
}
