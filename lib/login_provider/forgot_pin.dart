import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:parcsmart_driver/utils/common_widgets.dart';

class ForgotPin extends StatelessWidget {
  const ForgotPin({Key? key}) : super(key: key);
  final String forgotPinImage = 'assets/images/forgotPin-removebg-preview.png';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print('/////////////////////////////$width//////////////////////////');
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // padding: const EdgeInsets.only(top: 10),
                color: Colors.transparent,
                height: height * 0.4,
                width: width,
                child: Image(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(forgotPinImage),
                ),
              ),
              SizedBox(
                height: height * 0.05,
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
              SizedBox(
                height: height * 0.005,
              ),
              CommonWidgets.customButton(
                  onPressed: () {},
                  height: height * 0.06,
                  width: width,
                  btnName: 'Send Pin'),
            ],
          ),
        ),
      ),
    );
  }
}
