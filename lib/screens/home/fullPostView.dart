import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullpostView extends StatefulWidget {
  FullpostView({
    Key key,this.image
  }) : super(key: key);
  final AssetImage image;

  @override
  _FullpostViewState createState() => _FullpostViewState();
}

class _FullpostViewState extends State<FullpostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new PreferredSize(
      //     preferredSize:
      //         Size.fromHeight(58.0), // Change the height of the appbar
      //     child: CustomAppbar(
      //       isHome: false,
      //       leading: true,
      //       show_icon: false,
      //       elevation: 2.0,
      //       color: Colors.white,
      //       title: 'Room Rules',
      //     )),
      appBar: AppBar(
        title: Text(
          ' ',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData.fallback(),
        leading: InkWell(
          // focusColor: Colors.yellow,
          // highlightColor: Colors.yellow,
          // hoverColor: Colors.yellow,
          // splashColor: Colors.yellow,
          onTap: () {
            Navigator.maybePop(context);
          },
          child: Icon(Icons.close, size: 25, color: Colors.white),
        ),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(height: 1, color: Colors.black),
          Container(
              height: 340,
              decoration: BoxDecoration(
                color: Colors.black,

                image: DecorationImage(
                    image: widget.image, fit: BoxFit.fill),
                // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                // color: Colors.blue
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/new_icons/like_white.svg",
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      '  (34)',
                      style: TextStyle(fontSize: 14, fontFamily: 'Inter',color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/new_icons/comment_white.svg",
                      height: 20,
                      width: 25,
                    ),
                    Text(
                      '  (04)',
                      style: TextStyle(fontSize: 14, fontFamily: 'Inter',color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/new_icons/repost_white.svg",
                      height: 20,
                      width: 25,
                    ),
                    Text(
                      '  (03)',
                      style: TextStyle(fontSize: 14, fontFamily: 'Inter',color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
