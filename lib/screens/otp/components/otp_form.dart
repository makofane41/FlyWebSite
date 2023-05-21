// OtpForm.dart
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class OtpForm extends StatefulWidget {
  final Function(String) onPinEntered; // Define the callback function

  const OtpForm({Key key, this.onPinEntered}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  String pin1 = '';
  String pin2 = '';
  String pin3 = '';
  String pin4 = '';

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextNode({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  void updatePin(int pinIndex, String value) {
    setState(() {
      switch (pinIndex) {
        case 1:
          pin1 = value;
          break;
        case 2:
          pin2 = value;
          break;
        case 3:
          pin3 = value;
          break;
        case 4:
          pin4 = value;
          break;
      }
    });

    if (pinIndex == 4) {
      String pin = pin1 + pin2 + pin3 + pin4;
      widget.onPinEntered(pin); // Call the callback function
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              autofocus: true,
              obscureText: false,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
              decoration: otpInputDecoration,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                updatePin(1, value);
                nextNode(value: value, focusNode: pin2FocusNode);
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin2FocusNode,
              style: TextStyle(fontSize: 24),
              autofocus: true,
              decoration: otpInputDecoration,
              obscureText: false,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                updatePin(2, value);
                nextNode(value: value, focusNode: pin3FocusNode);
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin3FocusNode,
              style: TextStyle(fontSize: 24),
              autofocus: true,
              decoration: otpInputDecoration,
              obscureText: false,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                updatePin(3, value);
                nextNode(value: value, focusNode: pin4FocusNode);
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin4FocusNode,
              style: TextStyle(fontSize: 24),
              autofocus: true,
              decoration: otpInputDecoration,
              obscureText: false,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                updatePin(4, value);
                pin4FocusNode.unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
