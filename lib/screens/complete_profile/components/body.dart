import 'package:flutter/material.dart';
import 'package:flybuy/screens/home/home_screen.dart';
import 'package:flybuy/screens/login_success/login_success_screen.dart';

import '../../../constants.dart';
import './complete_profile_form.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  "Complete Profile",
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Complete your profile details",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                CompleteProfileForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  child: Text(
                    "Skip for now",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                Text(
                  "By continuing you confirm that you agree\nwith our terms and conditions",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
