import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fireauth/screens/auth/avatar_upload.dart';

// importing services file
import '../../services/auth/services.dart';
import '../../services/http_exception.dart';

// importing screens...
import './sign_up.dart';
import '../home/home.dart';
import './forgot_password.dart';

// importing ui
import '../../widgets/responsive_ui.dart';
import '../../widgets/textformfield.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-up';

  final String email;
  SignInScreen({Key key, this.email}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      await Provider.of<UserAuth>(context, listen: false)
          .signin(email, password);
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
    } on HttpException catch (err) {
      print(err);
      Toast.show(
        err.toString(),
        context,
        duration: Toast.LENGTH_LONG,
      );
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
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
                  // margin: EdgeInsets.only(left: 20),
                  child: Center(child: SvgPicture.asset('assets/new_icons/TTsm.svg')),
                  // child: Text(
                  //   "TT",
                  //   style: Theme.of(context).textTheme.headline1,
                  // ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Text(
                      "Sign in",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
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
                  height: 15,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Forgot ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter'),
                          // style: Theme.of(context)
                          //     .textTheme
                          //     .bodyText1
                          //     .copyWith(fontWeight: FontWeight.w400),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Text("password ?",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.redAccent,
                                  fontFamily: 'Inter')
                              // style:
                              //     Theme.of(context).textTheme.bodyText1.copyWith(
                              //           fontWeight: FontWeight.w400,
                              //           color: Colors.red,
                              //         ),
                              ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 25,
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : createAcc(),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "OR LOGIN WITH",
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
                  height: 25,
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
                  "Don’t have an account ? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                  child: Text("Sign up",
                      style: TextStyle(
                          color: Color(0xFF3550A3),
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            )),
      );

  Widget createAcc() => InkWell(
        onTap: _submit,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xFF3550A3),
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
          height: 50,
          child: Center(
            child: Text(
              "Login",
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
                border: Border.all(width: 1, color: Color(0xFFD8D8D8)),
              ),
              height: 50,
              // width: _width / 2 - 15,
              width: 150,
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 25,
                    width: 25,
                    child: Image.asset('assets/images/fb.png', scale: 0.5),
                  ),
                  Text("Facebook",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          letterSpacing: 0.15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: _submitGoogle,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(width: 1, color: Color(0xFFD8D8D8)),
              ),
              height: 50,
              // width: _width / 2 - 15
              width: 150,
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              // width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 25,
                    width: 25,
                    child: Image.asset('assets/images/google.png'),
                  ),
                  Text("Google",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          letterSpacing: 0.15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      );

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: _emailController,
      hint: "Username/ Email address",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      textEditingController: _passwordController,
      // icon: Icons.lock,
      hint: "Password",
      max: 1,
      // autovalidate: true,
      // autocorrect: false,
      // validator: (value) {
      //   return 'dhd';
      // },
    );
  }
}
