// import 'dart:html';
import 'package:fireauth/screens/home/profile_screens/about_us.dart';
import 'package:fireauth/screens/home/profile_screens/help.dart';
import 'package:fireauth/screens/home/profile_screens/room_rules.dart';
import 'package:fireauth/screens/home/profile_screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:fireauth/screens/home/profile_screens/profile_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';


// importing service....
import 'package:fireauth/services/auth/services.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  Profile({
    Key key,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              height: 181,
              width: double.maxFinite,
              color: Color(0xFFF6F6F8),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Container(
                      //   height: 100.0,
                      //   width: 100.0,
                      //   margin: EdgeInsets.all(8),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //         color: Colors.white, width: 2.5),
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(

                      //         // image: user.avatarURL == null ||
                      //         //         user.avatarURL == ""
                      //             image: AssetImage(
                      //                 "assets/icons/icon-user.png",
                      //               ),
                      //             // : NetworkImage(user.avatarURL),
                      //         fit: BoxFit.cover),
                      //   ),
                      // ),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).accentColor,
                        child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png')),
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Consumer<UserAuth>(
                          builder: (context, auth, _) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${auth.name}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'),
                                  ),
                                  SizedBox(height: 9.0),
                                  Text('${auth.email}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Inter'))
                                ],
                              )),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     Text(
                      //       'Neeraj Sharma',
                      //       style: TextStyle(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold,
                      //           fontFamily: 'Poppins'),
                      //     ),
                      //     SizedBox(height: 9.0),
                      //     Text('Neeraj@gmail.com',
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.normal,
                      //             fontFamily: 'Inter'))
                      //   ],
                      // )
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     Container(
                      //       child: ConstrainedBox(
                      //         constraints: BoxConstraints(
                      //           minWidth: MediaQuery.of(context)
                      //                   .size
                      //                   .width *
                      //               0.6,
                      //           maxWidth: MediaQuery.of(context)
                      //                   .size
                      //                   .width *
                      //               0.6,
                      //           minHeight: 30.0,
                      //           maxHeight: 100.0,
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(
                      //               left: 16, top: 16, bottom: 16),
                      //           child: Text('abc'),
                      //         ),
                      //       ),
                      //     ),
                      //     // Spacer(),
                      //     Row(
                      //       children: <Widget>[
                      //         Padding(
                      //           padding: const EdgeInsets.only(
                      //               left: 16,
                      //               right: 0,
                      //               top: 16,
                      //               bottom: 16),
                      //           child: Text('bjb'),
                      //         ),
                      //         // Padding(
                      //         //   padding: const EdgeInsets.only(
                      //         //       left: 16, right: 16, top: 16, bottom: 16),
                      //         //   child: AutoSizeText(
                      //         //     "MY ADDRESS",
                      //         //     minFontSize: 12.0,
                      //         //     style: TextStyle(
                      //         //         color: Colors.white,
                      //         //         fontSize: 14.0,
                      //         //         fontWeight: FontWeight.w700),
                      //         //   ),
                      //         // ),
                      //       ],
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Custom_widget(
                          number: 33,
                          text: 'Posts',
                        ),
                        Custom_widget(
                          number: 93,
                          text: 'Followers',
                        ),
                        Custom_widget(
                          number: 73,
                          text: 'Following',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.maxFinite,
              color: Colors.white70,
              child: Column(
                children: <Widget>[
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
            )
          ],
        ),
      ),
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

class Custom_widget extends StatefulWidget {
  final int number;
  final String text;
  const Custom_widget({Key key, this.number, this.text}) : super(key: key);

  @override
  _Custom_widgetState createState() => _Custom_widgetState();
}

class _Custom_widgetState extends State<Custom_widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Column(
          children: <Widget>[
            Text(
              widget.number.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Inter'),
            ),
            SizedBox(height: 5),
            Text(widget.text,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'Inter'))
          ],
        ));
  }
}
