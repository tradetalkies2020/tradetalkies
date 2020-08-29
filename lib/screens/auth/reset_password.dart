import 'package:flutter/material.dart';

import '../../widgets/responsive_ui.dart';
import '../../widgets/textformfield.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = '/sign-up';

  final String email;
  ResetPassword({Key key, this.email}) : super(key: key);

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  // final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: _large ? 65 : (_medium ? 55 : 35),
                ),
                Container(
                  // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "TT",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(
                  height: _large ? 25 : (_medium ? 15 : 5),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "Reset Password",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: _large ? 35 : (_medium ? 30 : 25),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: newPasswordTextFormField(),
                ),
                SizedBox(
                  height: _large ? 30 : (_medium ? 20 : 5),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: confirmNewPasswordTextFormField(),
                ),
                SizedBox(
                  height: _large ? 35 : (_medium ? 25 : 15),
                ),
                resetPass(),
                SizedBox(
                  height: _large ? 35 : (_medium ? 25 : 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget resetPass() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xFF3D96FF),
        ),
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        width: _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
        height: 50,
        child: Center(
          child: Text(
            "Reset Password",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      );

  Widget newPasswordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.visiblePassword,
      textEditingController: _newPasswordController,
      obscureText: true,
      max: 1,
      hint: "New Password",
    );
  }

  Widget confirmNewPasswordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.visiblePassword,
      textEditingController: _confirmPasswordController,
      obscureText: true,
      max: 1,
      hint: "Confirm New Password",
    );
  }
}
