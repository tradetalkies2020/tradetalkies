import 'package:flutter/material.dart';

// importing sign up and sign in file...
import './sign_up.dart';
import './sign_in.dart';
import './avatar_upload.dart';
import './forgot_password.dart';
import './reset_password.dart';
import 'package:fireauth/screens/auth/intro.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return IntroOverboardPage();
  }
}

//AvatarGenderAgeUpload(); //ForgotPassword(); //SignUpScreen(); //ResetPassword();
