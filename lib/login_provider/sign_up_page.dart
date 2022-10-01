import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:parcsmart_driver/utils/common_widgets.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

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
            left: width * 0.08, right: width * 0.08, top: height * 0.1),
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
              // SizedBox(height: height * 0.05),
              SizedBox(
//                width: width,
                height: height * 0.15,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: WebViewPlus(
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (controller) {
                      controller.loadUrl("assets/webview/index.html");
                    },
                    //  backgroundColor: Colors.red,
                    //    zoomEnabled: true,
                    //  gestureNavigationEnabled: true,

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
                height: height * 0.07,
                onPressed: () {},
                btnName: 'Sign Up',
                btnTextSize: 25,
              ),
              SizedBox(height: height * 0.05),
              CommonWidgets.customButton(
                onPressed: () {},
                btnName: 'Cancel',
                btnTextSize: 20,
                width: width * 0.85,
                height: height * 0.07,
              )
            ],
          ),
        ),
      ),
    );
  }
}
