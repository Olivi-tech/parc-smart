import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget customTextField({
    Widget? preFix,
    required String hintText,
    required double contentTopPadding,
    required double contentBottomPadding,
    required double contentLeftPadding,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: preFix,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
      double? btnTextSize,
      double? width}) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: Text(
            btnName,
            style: TextStyle(fontSize: btnTextSize),
          )),
    );
  }
}
