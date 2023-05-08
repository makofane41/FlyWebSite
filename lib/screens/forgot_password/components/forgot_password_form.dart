import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flybuy/screens/otp/otp_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/no_account_text.dart';
import '../../../components/custom_suffix_icon.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email;
  bool firstSubmit = false;

  Future<void> sendEmail(String email) async {
    final String apiUrl = 'https://prod-api.hustleshub.com/user/req/forgotpass';
    final response = await http.post(Uri.parse(apiUrl), body: {
      'email': email,
    });

    if (response.statusCode == 200) {
      print(this.email);
      Navigator.pushNamed(
        context,
        OTPScreen.routeName,
        arguments: this.email,
      );
    } else {
      final error = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            onSaved: (newEmail) => this.email = newEmail,
            onChanged: (email) {
              if (firstSubmit) _formKey.currentState.validate();
            },
            validator: (email) {
              if (email.isEmpty) {
                return kEmailNullError;
              } else if (email.isNotEmpty &&
                  !emailValidatorRegExp.hasMatch(email)) {
                return kInvalidEmailError;
              }

              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Mail.svg"),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.1),
        DefaultButton(
          text: 'Continue',
          press: () {
            if (_formKey.currentState.validate()) {
              sendEmail(email);
            }
            firstSubmit = true;
          },
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.1),
        NoAccountText(),
      ],
    );
  }
}
