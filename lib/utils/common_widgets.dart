import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonWidgets {
  static Widget customTextField({
    Widget? preFix,
    required String hintText,
    required double contentTopPadding,
    required double contentBottomPadding,
    required double contentLeftPadding,
    int? maxLength,
    TextInputType? textInputType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: preFix,
        fillColor: Colors.white.withOpacity(1),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.teal)),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(color: Colors.yellowAccent.withOpacity(0.5))),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.only(
            top: contentTopPadding,
            bottom: contentBottomPadding,
            left: contentLeftPadding),
        hintText: hintText,
      ),
    );
  }

  static Widget customButton(
      {required void Function()? onPressed,
      required String btnName,
      double? height,
      // Color? btnTextColor = Colors.white,
      double? btnTextSize = 25,
      //  Color? btnBackGroundColor = const Color(0xffEDEDDC),
      double? width}) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //  foregroundColor: btnTextColor,
            // backgroundColor: btnBackGroundColor,
          ),
          child: Text(
            btnName,
            style: TextStyle(
              fontSize: btnTextSize,
            ),
          )),
    );
  }
}
