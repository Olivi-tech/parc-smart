import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:parcsmart_driver/login_provider/sign_in_page.dart';
import 'package:parcsmart_driver/utils/common_widgets.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  final String signUpImage = 'assets/images/sign-up.png';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print('/////////////////////////////$width//////////////////////////');
    double height = MediaQuery.of(context).size.height;
    print('/////////////////////////////$height//////////////////////////');

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: width * 0.08,
            right: width * 0.08,
            top: height * 0.04,
            bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.3,
                width: width,
                child: Image(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(signUpImage),
                ),
              ),
              // Text(
              //   'Create Account',
              //   // textScaleFactor: 1,
              //   style: TextStyle(
              //       // color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 35,
              //       color: Colors.teal.withOpacity(1)),
              // ),
              SizedBox(height: height * 0.01),
              CommonWidgets.customTextField(
                  preFix: const Icon(
                    Icons.person,
                  ),
                  textInputType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z 0-9]'))
                  ],
                  contentBottomPadding: 15,
                  contentTopPadding: 15,
                  contentLeftPadding: 0.0,
                  hintText: 'Your Name'),
              SizedBox(height: height * 0.02),
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
              // SizedBox(height: height * 0.004),
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
              // SizedBox(height: height * 0.05),
              SizedBox(
                height: height * 0.25,
                child: Padding(
                  padding: EdgeInsets.only(left: width <= 360 ? 0 : 15),
                  child: WebViewPlus(
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (controller) {
                      controller.loadUrl("assets/webview/index.html");
                    },
                    backgroundColor: const Color(0xffEDEDDC),
                    // javascriptChannels: {
                    //   JavascriptChannel(
                    //       name: 'Captcha',
                    //       onMessageReceived: (JavascriptMessage message) {
                    //         print(
                    //             '/////////////////////message = $message //////////////////////');
                    //       })
                    // },
                  ),
                ),
              ),
              // SizedBox(height: height * 0.05),
              CommonWidgets.customButton(
                width: width * 0.85,
                height: height * 0.06,
                onPressed: () {},
                btnName: 'Sign Up',
              ),
              SizedBox(
                height: height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Have Account?',
                        style: TextStyle(
                          //  fontSize: 16,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()));
                      },
                      splashColor: Colors.redAccent,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Sign in',
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
              )
              // SizedBox(height: height * 0.01),
              // CommonWidgets.customButton(
              //   onPressed: () {},
              //   btnName: 'Sign in',
              //   width: width * 0.85,
              //   height: height * 0.06,
              //   btnTextColor: Colors.white,
              //   btnBackGroundColor: const Color(0xffEDEDDC),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
