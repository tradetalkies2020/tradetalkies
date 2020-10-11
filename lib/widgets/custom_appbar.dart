import 'package:fireauth/screens/home/coins.dart';
import 'package:fireauth/screens/home/notification.dart';
import 'package:fireauth/screens/home/profile_screens/about_us.dart';
import 'package:fireauth/screens/home/profile_screens/help.dart';
import 'package:fireauth/screens/home/profile_screens/notifications.dart';
import 'package:fireauth/screens/home/profile_screens/profile_info.dart';
import 'package:fireauth/screens/home/profile_screens/refer.dart';
import 'package:fireauth/screens/home/profile_screens/room_rules.dart';
import 'package:fireauth/screens/home/profile_screens/settings.dart';
import 'package:fireauth/services/auth/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatefulWidget {
  final bool leading;
  final bool show_icon;
  final double elevation;
  final String title;
  final Color color;
  final bool isHome;
  final bool isProfile;
  final int isOther;
  const CustomAppbar(
      {Key key,
      this.leading,
      this.show_icon,
      this.elevation,
      this.title,
      this.color,
      this.isHome,
      this.isProfile,
      this.isOther})
      : super(key: key);

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    // bool isAdmin = true;
    // const logoConfig = Logo;
    return AppBar(
      elevation: widget.elevation,
      backgroundColor: widget.color,
      automaticallyImplyLeading: widget.leading ? true : false,
      iconTheme: IconThemeData.fallback(),

      // centerTitle:true,
      // leading: widget.leading
      //     ? Builder(
      //         builder: (context) => IconButton(
      //           splashColor: Colors.transparent,
      //           highlightColor: Colors.transparent,
      //           // icon: ImageIcon(
      //           //   AssetImage("assets/icons/dashboard.png"),
      //           //   size: 18.0,
      //           //   color: Colors.white,
      //           // ),
      //           icon: new Icon(
      //             Icons.arrow_back,
      //             color: Colors.white,
      //           ),
      //           onPressed: () => Scaffold.of(context).openDrawer(),
      //         ),
      //       )
      //     : null,
      // title: Padding(
      //     padding: const EdgeInsets.only(left: 0.0),
      //     child: !logoConfig["isImage"]
      //         ? Text(
      //             logoConfig["title"],
      //             textAlign: TextAlign.center,
      //             style: new TextStyle(
      //               fontFamily: logoConfig["fontFamily"],
      //               color: Colors.white,
      //               fontWeight: FontWeight.bold,
      //               letterSpacing: 0.73,
      //               fontSize: 22.0,
      //             ),
      //           )
      //         : logoConfig["isAsset"]
      //             ? Image.asset(logoConfig["image"])
      //             : Image.network(logoConfig["image"])),
      title: Text(
        widget.title,
        style: widget.isHome?TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.bold):TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w500),
      ),

      actions: widget.show_icon
          ? <Widget>[
            InkWell(
              onTap: (){
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => Coins()));
              },
                          child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 13, 0, 13),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 1, color: Color(0xFFF4B844)),
                    color:Color(0xFFF6F6F8)
                  ),
                  height: 32,
                  // width: _width / 2 - 15,
                  width: 70,
                  // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
              ),
            ),
              new IconButton(
                  icon: new Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                  ),
                  // icon: SvgPicture.asset("assets/new_icons/bell.svg"),
                  onPressed: () {
                    Navigator.push(
                context, MaterialPageRoute(builder: (context) => Notifyy()));
                    // Navigator.of(context).pushNamed("/notifications");
                  }),
            ]
          : (widget.isProfile?<Widget>[
            InkWell(
              onTap: (){
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => Coins()));
              },
                          child: Padding(
                
                padding: const EdgeInsets.fromLTRB(13, 13, 0, 13),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 1, color: Color(0xFFF4B844)),
                    color:Color(0xFFF6F6F8)
                  ),
                  height: 32,
                  // width: _width / 2 - 15,
                  width: 70,
                  // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
              ),
            ),
              new IconButton(
                  icon: new Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  // icon: SvgPicture.asset("assets/new_icons/bell.svg"),
                  onPressed: () {
                    showModalBottomSheet(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter set) {
                                return Container(
                                  // height: 1200,
                                  // color: Colors.white,
                                  child: SingleChildScrollView(
                                                                      child: Column(
                children: <Widget>[
                  SizedBox(height:20),
                  Custom_listTile(
                    onTap: 1,
                    icon: "assets/new_icons/user.svg",
                    title: 'Profile info',
                    subtitle: 'Change your account information',
                  ),
                  Divider(
                    height: 1.0,
                  ),
                  Custom_listTile(
                    onTap: 2,
                    icon: "assets/new_icons/gift.svg",
                    title: 'Refer your friend',
                    subtitle: 'Share your friends about this app',
                  ),
                  Divider(
                    height: 1.0,
                  ),
                  Custom_listTile(
                    onTap: 3,
                    icon: "assets/new_icons/book-open.svg",
                    title: 'Room rules',
                    subtitle: 'Know more about the rules of the rooms',
                  ),
                  Divider(
                    height: 1.0,
                  ),
                  Custom_listTile(
                    onTap: 4,
                    icon: "assets/new_icons/settings.svg",
                    title: 'Settings',
                    subtitle: 'Notifications, app preference',
                  ),
                  Divider(
                    height: 1.0,
                  ),
                  Custom_listTile(
                    onTap: 5,
                    icon: "assets/new_icons/headphones.svg",
                    title: 'Help',
                    subtitle: 'We are there to help you',
                  ),
                  Divider(
                    height: 1.0,
                  ),
                  Custom_listTile(
                    onTap: 6,
                    icon: "assets/new_icons/gitlab.svg",
                    title: 'About us',
                    subtitle: 'Know more about Tradetalkies',
                  ),
                  Divider(
                    height: 1.0,
                  ),
                  Custom_listTile(
                    onTap: 7,
                    icon: "assets/new_icons/star.svg",
                    title: 'Rate us',
                    subtitle: 'Give us a rating about the app',
                  ),
                  Divider(
                    height: 1.0,
                  ),
                  ListTile(
                    onTap: () {
                      // Navig/ator.pop(context);
                      // Navigator.popUntil(context, (route) => false);
                      Navigator.of(context).pop();

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                      Provider.of<UserAuth>(context, listen: false).logout();
                    },
                    dense: true,
                    // contentPadding: EdgeInsets.all(5),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/new_icons/log-in.svg"),
                      // child: Image.asset(
                      //   "assets/new_icons/log-in.svg",
                      //   fit: BoxFit.contain,
                      //   width: 20,
                      //   // color: Colors.black,
                      //   height: 20,
                      //   // color: pageIndex == 0
                      //   //     ? Colors.blue
                      //   //     : Theme.of(context).hintColor,
                      // ),
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          color: Color(0xFF060606)),
                    ),
                    // subtitle: Text(widget.subtitle,style: TextStyle(fontFamily: 'Inter',fontSize: 14,color: Color(0xFF060606))),
                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                  ),
                  // Custom_listTile(icon: "assets/icons/logout.png",title: 'Logout',subtitle: null,),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
                                  ),
                                );
                              });
                            },

                            // builder: (context) =>
                          );
                    // Navigator.of(context).pushNamed("/notifications");
                  }),
            ]:(widget.isOther==1?<Widget>[InkWell(
              onTap: (){
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => Coins()));
              },
                          child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 1, color: Color(0xFFF4B844)),
                    color:Color(0xFFFFFFFF)
                  ),
                  height: 32,
                  // width: _width / 2 - 15,
                  width: 70,
                  // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
              ),
            )]:null)),
    );
  }
}

class Custom_listTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String icon;
  final int onTap;
  const Custom_listTile(
      {Key key, this.title, this.subtitle, this.icon, this.onTap})
      : super(key: key);

  @override
  _Custom_listTileState createState() => _Custom_listTileState();
}

class _Custom_listTileState extends State<Custom_listTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.onTap == 1)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profile_info(
                        forEdit: false,
                      )));
                      if (widget.onTap == 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Refer()));
        }
        if (widget.onTap == 3) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Room_Rules()));
        }
        if (widget.onTap == 4) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()));
        }
        if (widget.onTap == 6) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => About_us()));
        }
        if (widget.onTap == 5) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Help()));
        }
      },
      dense: true,
      // contentPadding: EdgeInsets.all(5),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(widget.icon),
        // child: Image.asset(
        //   widget.icon,
        //   fit: BoxFit.contain,
        //   width: 23,
        //   // color: Colors.black,
        //   height: 23,
        //   // color: pageIndex == 0
        //   //     ? Colors.blue
        //   //     : Theme.of(context).hintColor,
        // ),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
            letterSpacing: 0.2,
            fontWeight: FontWeight.normal,
            fontSize: 15,
            fontFamily: 'Inter',
            color: Color(0xFF000000)),
      ),
      subtitle: Text(widget.subtitle,
          style: TextStyle(
              fontFamily: 'Inter', fontSize: 12, color: Color(0xFF606060))),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 30,
      ),
    );
  }
}
