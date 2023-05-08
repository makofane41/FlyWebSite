import 'package:flutter/material.dart';

import './components/body.dart';

class RegisterSuccessScreen extends StatelessWidget {
  static const routeName = "/register-success";
  final String email;

  RegisterSuccessScreen({this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: SizedBox(),
        title: Text("Register Success"),
      ),
      body: Body(),
    );
  }
}
