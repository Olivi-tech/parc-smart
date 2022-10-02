import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
                color: const Color(0xffEDEDDC),
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
                hintText: 'Your 4 Digit Pin',
                contentBottomPadding: 15,
                contentLeftPadding: 0,
                maxLength: 4,
                textInputType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                contentTopPadding: 15,
              ),
              CommonWidgets.customButton(
                width: width * 0.85,
                height: height * 0.06,
                onPressed: () {},
                btnName: 'Sign In',
                btnTextColor: Colors.white,
                btnBackGroundColor: const Color(0xffEDEDDC),
              ),
              SizedBox(
                height: height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Don\'t have account?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const SignIn()));
                      },
                      splashColor: Colors.redAccent,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
