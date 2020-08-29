import 'package:flutter/material.dart';
// import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:fireauth/services/auth/page_model.dart';
import 'package:fireauth/screens/auth/overboard.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:fireauth/main.dart';
import 'package:fireauth/screens/auth/sign_in.dart';

class IntroOverboardPage extends StatefulWidget {
  static const routeName = '/IntroOverboardPage';

  @override
  _IntroOverboardPageState createState() => _IntroOverboardPageState();
}

class _IntroOverboardPageState extends State<IntroOverboardPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void gotoScreen(context) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.setBool('seen', true);

    Navigator.push(context,MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          // _globalKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Skip clicked"),
            
          // ));
          gotoScreen(context);
        },
        finishCallback: () {
          // _globalKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Finish clicked"),
          // ));
          gotoScreen(context);
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: const Color(0xFFFFFFFF),
        imageAssetPath: 'assets/images/avatar.png',
        title: 'TT',
        // body: 'The Franchise Group',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFFFFFFFF),
        imageAssetPath: 'assets/images/google.png',
        title: 'TT',
        // body: 'This a assignment app by The Franchise Group',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFFFFFFFF),
        imageAssetPath: 'assets/images/avatar.png',
        title: 'TT',
        // body: 'This is the intro slider',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFFFFFFFF),
        imageAssetPath: 'assets/images/fb.png',
        title: 'TT',
        // body: 'This is the intro slider',
        doAnimateImage: true),
    // PageModel.withChild(
    //     child: Padding(
    //       padding: EdgeInsets.only(bottom: 25.0),
    //       child:
    //           Image.asset('assets/images/02.png', width: 300.0, height: 300.0),
    //     ),
    //     color: Color(0xFF5886d6),
    //     doAnimateChild: false)
  ];
}
