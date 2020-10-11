import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
class Refer extends StatefulWidget {
  Refer({
    Key key,
  }) : super(key: key);

  @override
  _ReferState createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  String referLink = 'SASIKUMAR187234';

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
          child: CustomAppbar(
            isHome: false,
            leading: true,
            show_icon: false,
            isProfile: false,
            elevation: 2.0,
            color: Colors.white,
            title: 'Refer a friend',
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
      //                         builder: (context) => Refer(
      //                               firstVisit: true,forEdit: true,
      //                             )));
      //               },
      //               child: Text('Edit info',
      //                   style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
      //             ),
      //           )
      //         ],
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // color: Colors.yellow,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 127.0,
                      width: 224.0,
                      // margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //     color: Colors.white, width: 2.5),
                        // shape: BoxShape.circle,
                        image: DecorationImage(

                            // image: user.avatarURL == null ||
                            //         user.avatarURL == ""
                            image: AssetImage(
                              "assets/images/refer.png",
                            ),
                            // : NetworkImage(user.avatarURL),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Invite a friend.  Get free 100 Tradetalkies coin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: 13,
                ),

                Text(
                  'Once they create account, you’ll both get a free tradetalkies coins.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Inter'),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 4,
                  color: Color(0xFFF1F1F1),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Send invite',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Tap to copy your link',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Inter'),
                ),
                SizedBox(
                  height: 18,
                ),
                DottedBorder(
                  color: Color(0xFF8E8E8E).withOpacity(0.5),
                  radius: Radius.circular(5),
                  borderType: BorderType.RRect,
                  strokeWidth: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Color(0xFF8E8E8E),style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xFFF9F9F9),
                    ),
                    // margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                    width: _large
                        ? _width - 45
                        : (_medium ? _width - 35 : _width - 25),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            referLink,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Inter'),
                          ),
                          GestureDetector(
                              onTap: () {
                                Clipboard.setData(new ClipboardData(text: referLink));
                                // Clipboard.setData(ClipboardData(text: quote));
                                // ClipboardManager.copyToClipBoard(
                                //     referLink);
                                    Toast.show(
        "Copied to clipboard",
        context,
        duration: Toast.LENGTH_LONG,
      );
                              },
                              child: Text(
                                'COPY',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    color: Color(0xFF3550A3)),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),

                // SvgPicture.asset("assets/images/referr.svg")
                // AssetImage(assetName),
                // SvgPicture.asset(
                //                         "assets/new_icons/.svg",
                //                         // height: 20,
                //                         // width: 20,
                //                       ),
              ],
            ),
          ),
          InkWell(
            // onTap: () {
            //   Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ForgotPassword(),
            //     ),
            //   );
            // },
            onTap: null,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xFF3550A3),
              ),
              margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
              width:
                  _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
              height: 50,
              child: Center(
                child: Text(
                  "Invite Friends",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
