import 'package:flutter/material.dart';
import 'package:flybuy/screens/otp/otp_screen.dart';
import 'package:flybuy/screens/register_success/register_success_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String firstName, lastName, phone, address;
  final List<String> errors = [];
  bool remember = false;
  bool firstSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildAddressFormField(context),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                print(this.phone);
                Navigator.pushNamed(
                  context,
                  RegisterSuccessScreen.routeName,
                  arguments: this.phone,
                );
              }
              firstSubmit = true;
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      onSaved: (newPhone) => this.phone = newPhone,
      onChanged: (phone) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (phone) {
        if (phone.isEmpty) {
          return kPhoneNumberNullError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Phone.svg"),
      ),
      keyboardType: TextInputType.phone,
    );
  }

  TextFormField buildAddressFormField(BuildContext context) {
    return TextFormField(
      onSaved: (newAddress) => this.address = newAddress,
      onChanged: (address) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (address) {
        if (address.isEmpty) {
          return kAddressNullError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        suffixIcon: IconButton(
          icon: Icon(Icons.location_on),
          onPressed: () async {
            final selectedLocation = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocationPicker()),
            );
            if (selectedLocation != null) {
              setState(() {
                address = selectedLocation;
              });
            }
          },
        ),
      ),
      keyboardType: TextInputType.streetAddress,
    );
  }
}

class LocationPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement your location picker UI here
    return Container();
  }
}
