import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fireauth/screens/home/passbook.dart';
import 'package:fireauth/screens/home/priceAlert.dart';
import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

class Coins extends StatefulWidget {
  Coins({
    Key key,
  }) : super(key: key);

  @override
  _CoinsState createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  // String referLink = 'SASIKUMAR187234';
  String str1 = 'About Trade Takie coins';
  String str2 =
      'Get hassle-free solutions to all your queries at Tradetalkies Customer Care. Taking in regular feedback from all our users our customer success team has collated an exhaustive list of user queries, basis which we have built an in-app help and support section to meet all your needs.';
  String str3 = 'Get hassle-free solutions to all your queries at Tradetalkies Customer Care. Taking in regular feedback from all our users our customer success team has collated an exhaustive list of user queries, basis which we have built an in-app help and support section to meet all your needs.';

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      appBar: new PreferredSize(
          preferredSize:
              Size.fromHeight(58.0), // Change the height of the appbar
          child: AppBar(
            title: Text(
              'Trade talkie Coin',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            automaticallyImplyLeading: true,
            elevation: 2,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData.fallback(),
            actions: [
              IconButton(
                  icon:
                      Icon(Icons.error_outline, color: Colors.black, size: 25),
                  onPressed: () {
                    showModalBottomSheet(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, StateSetter set) {
                          return Container(
                            margin: EdgeInsets.only(left: 20), 
                            // height: 1200,
                            // color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height:20),
                                  Text(
                                    str1,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height:20),

                                  Text(
                                    str2,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                        height: 1.5,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height:20),

                                  Text(
                                    str3,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                        height: 1.5,

                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height:20),

                                ],
                              ),
                            ),
                          );
                        });
                      },

                      // builder: (context) =>
                    );
                  })
            ],
            // leading: InkWell(
            //   // focusColor: Colors.yellow,
            //   // highlightColor: Colors.yellow,
            //   // hoverColor: Colors.yellow,
            //   // splashColor: Colors.yellow,
            //   onTap: () {
            //     Navigator.maybePop(context);
            //   },
            //   child: Icon(Icons.close, size: 25, color: Colors.black),
            // ),
            // leading: Icon(Icons.cancel),
            // actions: widget.forEdit
            //     ? null
            //     : <Widget>[
            //         Padding(
            //           padding: const EdgeInsets.all(20.0),
            //           child: InkWell(
            //             onTap: () {
            //               Navigator.pop(context);
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => post(
            //                             firstVisit: true,forEdit: true,
            //                           )));
            //             },
            //             child: Text('Edit info',
            //                 style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
            //           ),
            //         )
            //       ],
          )),
      // appBar: AppBar(
      //   title: Text(
      //     'Profile Info',
      //     style: TextStyle(
      //         color: Colors.black,
      //         fontFamily: 'Poppins',
      //         fontSize: 18,
      //         fontWeight: FontWeight.w500),
      //   ),
      //   automaticallyImplyLeading: true,
      //   elevation: 2,
      //   backgroundColor: Colors.white,
      //   iconTheme: IconThemeData.fallback(),
      //   actions: widget.forEdit
      //       ? null
      //       : <Widget>[
      //           Padding(
      //             padding: const EdgeInsets.all(20.0),
      //             child: InkWell(
      //               onTap: () {
      //                 Navigator.pop(context);
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => Coins(
      //                               firstVisit: true,forEdit: true,
      //                             )));
      //               },
      //               child: Text('Edit info',
      //                   style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
      //             ),
      //           )
      //         ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 98.0,
                  width: 102.0,
                  // margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //     color: Colors.white, width: 2.5),
                    // shape: BoxShape.circle,
                    image: DecorationImage(

                        // image: user.avatarURL == null ||
                        //         user.avatarURL == ""
                        image: AssetImage(
                          "assets/images/reward.png",
                        ),
                        // : NetworkImage(user.avatarURL),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PassBook()));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(width: 1, color: Color(0xFFE1E1E1)),
                    color: Color(0xFFFFFFFF)),
                height: 40,
                // width: _width / 2 - 15,
                width: 183,
                // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'Balance : ',
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                fontFamily: 'Poppins'),
                          ),
                          SvgPicture.asset('assets/new_icons/coin.svg'),
                          Text(" 50",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 14.0,
                                  letterSpacing: 0.15,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Color(0xFF000000),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Earn Trade talkie coins by have lots of benifits and get help from expertise',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: 20,
            ),
            CoinTile(
              index: "1",
              text: 'Successfully created account',
              coin: '50',
            ),
            CoinTile(
              index: "2",
              text: 'Open the app daily and get rewarded',
              coin: '50',
            ),
            CoinTile(
              index: "3",
              text: 'Refer friend and creates his account in our app',
              coin: '50',
            ),
            CoinTile(
              index: "4",
              text: 'When you create a room and interact',
              coin: '50',
            ),
            CoinTile(
              index: "5",
              text: 'When you post something on the feed',
              coin: '50',
            ),
            CoinTile(
              index: "6",
              text: 'When you like, Comment, Share or repost',
              coin: '50',
            ),
          ],
        ),
      ),
    );
  }
}

class CoinTile extends StatefulWidget {
  const CoinTile({Key key, this.text, this.coin, this.index}) : super(key: key);
  final String index, text, coin;

  @override
  _CoinTileState createState() => _CoinTileState();
}

class _CoinTileState extends State<CoinTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 2,
          color: Color(0xFFF1F1F1),
        ),
        SizedBox(
          height: 5,
        ),
        ListTile(
          // dense: ,
          leading: Text(
            widget.index,
            style: TextStyle(
                color: Color(0xFFBEBEBE),
                fontWeight: FontWeight.w700,
                fontSize: 30,
                fontFamily: 'Inter'),
          ),
          title: Text(
            widget.text,
            style: TextStyle(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: 'Inter'),
          ),
          trailing: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: Column(
              children: [
                Container(
                  width: 45,
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/new_icons/coin.svg'),
                      Text(" ${widget.coin}",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                              fontSize: 15.0,
                              letterSpacing: 0.15,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text("You earn",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        letterSpacing: 0.15,
                        fontWeight: FontWeight.w400))
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
