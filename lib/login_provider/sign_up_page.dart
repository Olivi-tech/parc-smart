import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:parcsmart_driver/utills/common_widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            left: width * 0.04, right: width * 0.04, top: height * 0.1),
        child: SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  // color: Colors.white
                ),
              ),
              SizedBox(height: height * 0.05),
              CommonWidgets.customTextField(
                  preFix: const Icon(
                    Icons.person,
                    // size: 25,
                  ),
                  contentBottomPadding: 15,
                  contentTopPadding: 15,
                  contentLeftPadding: 0.0,
                  hintText: 'Your Name'),
              SizedBox(height: height * 0.029),
              IntlPhoneField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                dropdownTextStyle: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  fillColor: Colors.white,
                  constraints: const BoxConstraints(maxHeight: 70),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                ),
              ),
              SizedBox(height: height * 0.004),
              CommonWidgets.customTextField(
                preFix: const Icon(Icons.pin),
                hintText: 'Your 4 Digit Pin',
                contentBottomPadding: 15,
                contentLeftPadding: 0,
                contentTopPadding: 15,
              ),
              SizedBox(height: height * 0.05),
              CommonWidgets.customButton(
                  width: width * 0.95,
                  height: height * 0.07,
                  btnTextSize: 25,
                  onPressed: () {},
                  btnName: 'Sign Up')
            ],
          ),
        ),
      ),
    );
  }
}
