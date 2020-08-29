import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// importing services file
import '../../services/auth/services.dart';
import '../../services/http_exception.dart';

import '../../widgets/responsive_ui.dart';
import '../../widgets/textformfield.dart';
import './reset_password.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/sign-up';

  final String email;
  ForgotPassword({Key key, this.email}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  final _emailController = TextEditingController();

  Future<void> _submit() async {
    final String email = _emailController.text;
    print(email);
    if (email == '') {
      Toast.show(
        'Please enter your email',
        context,
        duration: Toast.LENGTH_LONG,
      );
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<UserAuth>(context, listen: false)
            .forgotPassword(email);
        _emailController.text = '';
        print('Email sent');
        Toast.show(
          'Check your mail for further details',
          context,
          duration: Toast.LENGTH_LONG,
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ResetPassword(),
        //   ),
        // );
        // print("going on home page");
      } on HttpException catch (err) {
        print(err);
        Toast.show(
          err.toString(),
          context,
          duration: Toast.LENGTH_LONG,
        );
      } catch (error) {
        const errorMessage = 'Email not found';
        Toast.show(
          errorMessage.toString(),
          context,
          duration: Toast.LENGTH_LONG,
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
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
                    "Forget Password",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: _large ? 25 : (_medium ? 20 : 10),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "Enter the registered Email address with Trade Talkies",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: _large ? 55 : (_medium ? 45 : 35),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: emailTextFormField(),
                ),
                SizedBox(
                  height: _large ? 35 : (_medium ? 25 : 15),
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : createAcc(),
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

  Widget createAcc() => InkWell(
        onTap: _submit,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xFF3D96FF),
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
          height: 50,
          child: Center(
            child: Text(
              "Send Reset link",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      );

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: _emailController,
      hint: "Email address",
    );
  }
}
