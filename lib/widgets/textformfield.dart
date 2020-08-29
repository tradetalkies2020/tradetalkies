import 'package:flutter/material.dart';
import './responsive_ui.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  // FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  // bool autovalidate = false;
  bool obscureText;
  // bool autocorrect = true;
  final IconData icon;
  final String initVal;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;
  int min;
  int max;
  final bool enabled;

  CustomTextField({
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.min,
    this.max,
    this.obscureText = false,
    this.enabled,
    this.initVal,
    // this.validator,
    // this.autovalidate = false,
    // this.autocorrect=true,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: max,
        // validator: validator,
        obscureText: obscureText,
        minLines: min,
        initialValue: initVal,
        enabled: enabled,
        // autovalidate: autovalidate,
        // autocorrect: autocorrect,
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3D96FF), width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFC9C9C9),
              width: 1.0,
            ),
          ),
          hintStyle: TextStyle(
            color: Color(0xFF000000).withOpacity(0.3),
            fontFamily: 'Inter',
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
