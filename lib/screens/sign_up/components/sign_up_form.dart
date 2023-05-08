import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flybuy/screens/complete_profile/complete_profile_screen.dart';
import 'package:flybuy/screens/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String firstName, lastName, email, password, confirmPassword;
  final List<String> errors = [];
  bool firstSubmit = false;
  bool remember = false;

  Future<void> registerUser(
      String firstName, String lastName, String email, String password) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    final String apiUrl = 'https://prod-api.hustleshub.com/user/auth/register';
    final response = await http.post(Uri.parse(apiUrl), body: {
      'fname': firstName,
      'lname': lastName,
      'email': email,
      'password': password,
    });
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      print(this.email);
      Navigator.pushNamed(
        context,
        OTPScreen.routeName,
        arguments: this.email,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 5),
            backgroundColor: Color.fromARGB(255, 7, 67, 233),
            content: Text("Registration Sucessfully, Please Verify OTP")),
      );
    } else {
      // Handle error
      final error = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 5),
            backgroundColor: Color.fromARGB(255, 224, 8, 8),
            content: Text(error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                registerUser(firstName, lastName, email, password);
              }
              firstSubmit = true;
            },
          ),
        ],
      ),
    );
  }

  //first name
  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newFirstName) => this.firstName = newFirstName,
      onChanged: (email) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (firstName) {
        if (firstName.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "First Name",
          hintText: "Enter your First Name",
          suffixIcon: Icon(Icons.person)),
      keyboardType: TextInputType.text,
    );
  }

  //Last name
  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newLastName) => this.lastName = newLastName,
      onChanged: (email) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (lastName) {
        if (lastName.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Last Name",
          hintText: "Enter your Last Name",
          suffixIcon: Icon(Icons.person)),
      keyboardType: TextInputType.text,
    );
  }

  //email
  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newEmail) => this.email = newEmail,
      onChanged: (email) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (email) {
        if (email.isEmpty) {
          return kEmailNullError;
        } else if (email.isNotEmpty && !emailValidatorRegExp.hasMatch(email)) {
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
    );
  }

//password
  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => this.password = newPassword,
      onChanged: (password) {
        if (firstSubmit) _formKey.currentState.validate();
        this.password = password;
      },
      validator: (password) {
        if (password.isEmpty) {
          return kPassNullError;
        } else if (password.isNotEmpty && password.length <= 7) {
          return kShortPassError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => this.confirmPassword = newPassword,
      onChanged: (password) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (password) {
        if (password != this.password) {
          return kMatchPassError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Repeat your password",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }
}
