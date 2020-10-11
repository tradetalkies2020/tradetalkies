import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_overboard/src/circular_clipper.dart';
import 'package:fireauth/services/auth/page_model.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:flutter_overboard/src/overboard_animator.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_overboard/src/page_model.dart';

enum SwipeDirection { LEFT_TO_RIGHT, RIGHT_TO_LEFT, SKIP_TO_LAST }

class OverBoard extends StatefulWidget {
  final List<PageModel> pages;
  final Offset center;
  final bool showBullets;
  final VoidCallback finishCallback;
  final VoidCallback skipCallback;
  final OverBoardAnimator animator;
  final String skipText, nextText, finishText;

  OverBoard(
      {Key key,
      @required this.pages,
      this.center,
      this.showBullets,
      this.skipText,
      this.nextText,
      this.finishText,
      @required this.finishCallback,
      this.animator,
      this.skipCallback})
      : super(key: key);

  @override
  _OverBoardState createState() => _OverBoardState();
}

class _OverBoardState extends State<OverBoard> with TickerProviderStateMixin {
  OverBoardAnimator _animator;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  ScrollController _scrollController = new ScrollController();
  double _bulletPadding = 4.0, _bulletSize = 7.0, _bulletContainerWidth = 0;

  int _counter = 0, _last = 0;
  int _total = 0;
  double initial = 0, distance = 0;
  Random random = new Random();
  SwipeDirection _swipeDirection = SwipeDirection.RIGHT_TO_LEFT;

  @override
  void initState() {
    super.initState();

    _animator = new OverBoardAnimator(this);
    _total = widget.pages.length;
    print('total is ${_total}');
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: _getStack(),
      ),
    );
  }

  _getStack() {
    PageModel page = widget.pages[_counter];

    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        initial = details.globalPosition.dx;
      },
      onPanUpdate: (DragUpdateDetails details) {
        distance = details.globalPosition.dx - initial;
      },
      onPanEnd: (DragEndDetails details) {
        initial = 0.0;
        setState(() {
          _last = _counter ;
          // print('last is $_last');
        });
        if (distance > 1 && _counter > 0) {
          setState(() {
            _counter--;
            // print('counter- is $_counter');
            _swipeDirection = SwipeDirection.LEFT_TO_RIGHT;
          });
          // _animate();
        } else if (distance < 0 && _counter < _total - 1) {
          setState(() {
            _counter++;
            // print('counter+ is $_counter');

            _swipeDirection = SwipeDirection.RIGHT_TO_LEFT;
          });
          // _animate();
        }
      },
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 63.0),
            // height: 50.0,
            child: new Text(
              page.title,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(height: 55),
          page.doAnimateImage
              ? Container(
                  width: _large
                      ? _width - 45
                      : (_medium ? _width - 35 : _width - 25),
                  height: 340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFDADADA)),
                  // padding: EdgeInsets.only(bottom: 45.0),
                  child: null,

                  //     child: new Image.asset(page.imageAssetPath,
                  //         // width: 358.0, height: 293.0,
                  //         // color: Colors.red
                  // width: _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),

                  //         // color: Color(0xFFDADADA)
                  //         ),
                )
              :SvgPicture.asset(page.imageAssetPath)
          ,

          // _getPage(_last),
          // AnimatedBuilder(
          //   animation: _animator.getAnimator(),
          //   builder: (context, child) {
          //     return ClipOval(
          //         clipper: CircularClipper(
          //             _animator.getAnimator().value, widget.center),
          //         child: _getPage(_counter));
          //   },
          //   child: Container(),
          // ),
          SizedBox(
            height: 80,
          ),
          InkWell(
            onTap: _counter < _total - 1 ? _next : widget.finishCallback,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xFF3550A3),
              ),
              // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width:
                  _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
              height: 50,
              child: Center(
                child: Text(
                  _counter < _total - 1 ? "Continue" : "Get Started",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
              // padding: EdgeInsets.all(15),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Have an account ?",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inter'),
              ),
              InkWell(
                onTap:
                    (widget.skipCallback != null ? widget.skipCallback : _skip),
                // onTap: () {

                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(
                //   //     builder: (context) {
                //   //       return SignUpScreen();
                //   //     },
                //   //   ),
                //   // );
                // },
                child: Text(
                  " Sign In",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Color(0xFF3550A3),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter'),
                ),
              ),
            ],
          )),
          SizedBox(height: 20),
          Container(
            // margin: EdgeInsets.only(top:110.0),
            child: Center(child: LayoutBuilder(
              builder: (context, constraints) {
                _bulletContainerWidth = constraints.maxWidth - 40.0;
                return Container(
                  // padding: const EdgeInsets.all(0.0),
                  child: ((widget.showBullets ?? true)
                      ? SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < _total; i++)
                                Padding(
                                  padding: EdgeInsets.all(_bulletPadding),
                                  child: Container(
                                    height: _bulletSize,
                                    width: _bulletSize,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (i == _counter
                                            ? Color(0xFF2E279D)
                                            : Color(0xFFBBBBBB))),
                                  ),
                                )
                            ],
                          ),
                        )
                      : Container()),
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  _getPage(index) {
    PageModel page = widget.pages[index];
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 60.0),
          child: new Text(
            page.title,
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: Colors.black,
                fontSize: 32.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w900),
          ),
        ),
        page.doAnimateImage
            ? AnimatedBoard(
                animator: _animator,
                child: new Padding(
                  padding: new EdgeInsets.only(bottom: 25.0),
                  child: new Image.asset(page.imageAssetPath,
                      width: 358.0,
                      height: 293.0,
                      // color: Colors.red
                      color: Color(0xFFDADADA)),
                ),
              )
            : Image.asset(
                page.imageAssetPath,
                width: 358.0, height: 293.0,
                // color: Color(0xFFDADADA)
              ),

        // Padding(
        //   padding: new EdgeInsets.only(
        //       bottom: 75.0, left: 30.0, right: 30.0),
        //   child: new Text(
        //     page.body,
        //     textAlign: TextAlign.center,
        //     style: new TextStyle(
        //       color: Colors.white,
        //       fontSize: 18.0,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  _next() {
    setState(() {
      _swipeDirection = SwipeDirection.RIGHT_TO_LEFT;
      // print('last was $_last');
      _last = _counter;
      // print('last is $_last');
      // print('counter was $_counter');

      _counter++;
      // print('counter is $_counter');

    });
    _animate();
  }

  _skip() {
    setState(() {
      _swipeDirection = SwipeDirection.SKIP_TO_LAST;
      _last = _counter;
      _counter = _total - 1;
    });
    _animate();
  }

  _animate() {
    _animator.getController().forward(from: 0.0);

    double _bulletDimension = (_bulletPadding * 2) + (_bulletSize);
    double _scroll = _bulletDimension * _counter;
    double _maxScroll = _bulletDimension * _total - 1;
    if (_scroll > _bulletContainerWidth &&
        _swipeDirection == SwipeDirection.RIGHT_TO_LEFT) {
      double _scrollDistance =
          (((_scroll - _bulletContainerWidth) ~/ _bulletDimension) + 1) *
              _bulletDimension;
      _scrollController.animateTo(_scrollDistance,
          curve: Curves.easeIn, duration: Duration(milliseconds: 100));
    } else if (_scroll < (_maxScroll - _bulletContainerWidth) &&
        _swipeDirection == SwipeDirection.LEFT_TO_RIGHT) {
      _scrollController.animateTo(_scroll,
          curve: Curves.easeIn, duration: Duration(milliseconds: 100));
    } else if (_swipeDirection == SwipeDirection.SKIP_TO_LAST) {
      _scrollController.animateTo(_maxScroll,
          curve: Curves.easeIn, duration: Duration(milliseconds: 100));
    }
  }
}

class AnimatedBoard extends StatelessWidget {
  final Widget child;
  final OverBoardAnimator animator;

  const AnimatedBoard({Key key, this.animator, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: new Matrix4.translationValues(
          0.0, 50.0 * (1.0 - animator.getAnimator().value), 0.0),
      child: new Padding(
        padding: new EdgeInsets.only(bottom: 25.0),
        child: child,
      ),
    );
  }
}
