import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:parcsmart_driver/login_provider/forgot_pin.dart';
import 'package:parcsmart_driver/login_provider/privacy_policy.dart';
import 'package:parcsmart_driver/login_provider/sign_up_page.dart';
import 'package:parcsmart_driver/utils/common_widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);
  final String headerImage = 'assets/images/loginHeader.png';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print('/////////////////////////////$width//////////////////////////');
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: width * 0.08,
          right: width * 0.08,
          top: height * 0.038,
        ),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                height: height * 0.4,
                child: Image(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(headerImage),
                ),
              ),
              IntlPhoneField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                dropdownTextStyle: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'WhatsApp Number',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.yellowAccent.withOpacity(0.5))),
                  contentPadding: const EdgeInsets.only(bottom: 10),
                  fillColor: Colors.white,
                  constraints: const BoxConstraints(maxHeight: 70),
                  //  border: InputBorder.none,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                ),
              ),
              CommonWidgets.customTextField(
                preFix: const Icon(Icons.pin),
                contentBottomPadding: 15,
                hintText: 'Your 4 Digit Pin',
                contentLeftPadding: 0,
                maxLength: 4,
                textInputType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                contentTopPadding: 15,
              ),
              CommonWidgets.customButton(
                width: width,
                height: height * 0.06,
                onPressed: () {},
                btnName: 'Sign In',
              ),
              SizedBox(
                height: height * 0.009,
              ),
              CommonWidgets.customButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPin()));
                  },
                  width: width,
                  height: height * 0.06,
                  btnName: 'Forgot Pin?'),
              SizedBox(
                height: height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Don\'t have account?',
                        style: TextStyle(
                          // fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      splashColor: Colors.redAccent,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0,
                  left: width <= 360 ? width * 0.58 : width * 0.6,
                  top: 5,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy()));
                  },
                  child: const Text(
                    'Privacy Policy',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
