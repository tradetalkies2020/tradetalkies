import 'dart:async';

import 'package:fireauth/screens/auth/auth.dart';
import 'package:fireauth/screens/home/home.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key key,this.isAuth
  }) : super(key: key);
  final bool isAuth;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _height;

  double _width;

  double _pixelRatio;

  bool _large;

  bool _medium;
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    
    if(widget.isAuth){
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(selectedIndex: 0,fromPost: false,)));

    }
    else{
    Navigator.push(context, MaterialPageRoute(builder: (context) => Auth()));

    }
    
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      backgroundColor: Color(0xff3550A3),
      // backgroundColor: Color(0xffffffff),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // color: Colors.blue,
            width: _width,
            height: _height - 80,
            child: Center(child: SvgPicture.asset('assets/new_icons/TTbg.svg')),
          ),
          Text(
            'Made in India  🇮🇳',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}
