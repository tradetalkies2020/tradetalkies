import 'package:fireauth/screens/auth/avatar_upload.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// importing pages...
import '../home/home.dart';
import './sign_in.dart';

// importing widgets to use inside..
import '../../widgets/responsive_ui.dart';
import '../../widgets/textformfield.dart';

// importing services
import '../../services/auth/services.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';

  final String email;
  SignUpScreen({Key key, this.email}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.configure(
      onMessage: (msg) {
        print(msg);
        return;
      },
      onLaunch: (msg) {
        print(msg);
        return;
      },
      onResume: (msg) {
        print(msg);
        return;
      },
    );

    super.initState();
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    final String userName = _userNameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      await Provider.of<UserAuth>(context, listen: false).signup(
        email,
        password,
        userName,
      );
      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AvatarGenderAgeUpload(firstVisit: true,);
                        },
                      ),
                    );
      print("going on home page");
    } catch (err) {
      Toast.show(
        "Could not authenticate you. Please try again later.",
        context,
        duration: Toast.LENGTH_LONG,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _submitFB() async {
    print("facebook sign in");
    try {
      await Provider.of<UserAuth>(context, listen: false).signInWithFacebook();
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      print("going on home page");
    } catch (err) {
      Toast.show(
        "Could not authenticate you. Please try again later.",
        context,
        duration: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> _submitGoogle() async {
    print("Google sign in");
    try {
      await Provider.of<UserAuth>(context, listen: false).signInWithGoogle();
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      print("going on home page");
    } catch (err) {
      Toast.show(
        "Could not authenticate you. Please try again later.",
        context,
        duration: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _userNameController.dispose();
    _passwordController.dispose();
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
                  height: 55,
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
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "Create an account",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: userNameTextFormField(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: emailTextFormField(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: passwordTextFormField(),
                ),
                SizedBox(
                  height: 30,
                ),
                privacyPolicy(),
                SizedBox(
                  height: 25,
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : createAcc(),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "OR SIGN UP WITH",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 16,
                            // fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            
                          ),

                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                socialLogin(),
                SizedBox(
                  height:15,
                ),
                orSignIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orSignIn() => Center(
        child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Have an account ?",
                  style: TextStyle(color:Colors.black,fontFamily: 'Inter',fontSize: 16.0,),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignInScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    " Sign in",
                    style: TextStyle(color:Colors.blue,fontFamily: 'Inter',fontSize: 16.0,fontWeight: FontWeight.w600)
                  ),
                ),
              ],
            )),
      );

  Widget privacyPolicy() => Container(
        // padding: EdgeInsets.all(5),
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        alignment: Alignment.center,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: new TextSpan(
              text: 'By creating account, you agree to Trade Talkie',
              style: Theme.of(context).textTheme.headline3,
              // style: TextStyle(fontFamily: 'Inter',fontSize: 14.0,color:Color(0xFF6D6D6D)),
              children: <TextSpan>[
                TextSpan(
                  text: ' Privacy Policy',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                ),
                TextSpan(text: ' and'),
                TextSpan(
                  text: ' Terms and Conditions',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                ),
                
              ],
            ),
          ),
        ),
      );

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
              "Create Account",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      );

  Widget socialLogin() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: _submitFB,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(width: 1,color: Color(0xFFD8D8D8)),
                
              ),
              height: 50,
              // width: _width / 2 - 15,
              width: 150,
              margin: EdgeInsets.fromLTRB(20, 0,0, 0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 25,
                    width: 25,
                    child: Image.asset('assets/images/fb.png'),
                  ),
                  Text("Facebook",
                      style: TextStyle(color:Colors.black,fontFamily: 'Inter',fontSize: 16.0,letterSpacing: 0.15,fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: _submitGoogle,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0,20, 0),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(width: 1,color: Color(0xFFD8D8D8)),
              ),
              height: 50,
              // width: _width / 2 - 15,
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 25,
                    width: 25,
                    child: Image.asset('assets/images/google.png'),
                  ),
                  Text("Google",
                      style: TextStyle(color:Colors.black,fontFamily: 'Inter',fontSize: 16.0,letterSpacing: 0.15,fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      );

  Widget userNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: _userNameController,
      hint: "Username",
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: _emailController,
      hint: "Email Address",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      textEditingController: _passwordController,
      icon: Icons.lock,
      max: 1,
      hint: "Password",
    );
  }
}
