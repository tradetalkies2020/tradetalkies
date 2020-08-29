import 'package:flutter/material.dart';
import './responsive_ui.dart';

class ButtonFull extends StatelessWidget {
  final btnName;
  ButtonFull({Key key, @required this.btnName}) : super(key: key);

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Container(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).buttonColor,
        ),
        margin: EdgeInsets.fromLTRB(20, 0, 30, 0),
        width: _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
        height: 50,
        child: Center(
          child: Text(
            "$btnName",
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}
