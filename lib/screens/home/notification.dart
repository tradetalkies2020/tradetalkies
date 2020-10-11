import 'package:fireauth/screens/home/otherProfile.dart';
import 'package:fireauth/screens/home/priceAlert.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/feed_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Notifyy extends StatefulWidget {
  Notifyy({
    Key key,
  }) : super(key: key);

  @override
  _NotifyyState createState() => _NotifyyState();
}

class _NotifyyState extends State<Notifyy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
          preferredSize:
              Size.fromHeight(58.0), // Change the height of the appbar
          child: AppBar(
            title: Text(
              'Notifications',
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
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PriceAlert()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xFF8E8E8E),style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color(0xFF3550A3),
                      ),
                      height: 10,
                      width: 88,
                      child: Center(
                          child: Text(
                        '+ Price alert',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ))),
                ),
              )
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            NotifyTile(
              name: 'Neeraj sharma has commented on your post',
              path: 'assets/images/avatar.png',
              message: '8 mins ago',
              time: '11.11',
              count: '1',
            ),
            NotifyTile(
              name: 'Neeraj sharma has started following your profile',
              path: 'assets/images/avatar.png',
              message: '8 mins ago',
              time: '11.11',
              count: '1',
            ),
            NotifyTile(
              name: 'Neeraj sharma has commented on your post',
              path: 'assets/images/avatar.png',
              message: '8 mins ago',
              time: '11.11',
              count: '1',
            ),
            NotifyTile(
              name: 'Neeraj sharma has started following your profile',
              path: 'assets/images/avatar.png',
              message: '8 mins ago',
              time: '11.11',
              count: '1',
            ),
            NotifyTile(
              name: 'Neeraj sharma has commented on your post',
              path: 'assets/images/avatar.png',
              message: '8 mins ago',
              time: '11.11',
              count: '1',
            ),
            NotifyTile(
              name: 'Neeraj sharma has started following your profile',
              path: 'assets/images/avatar.png',
              message: '8 mins ago',
              time: '11.11',
              count: '1',
            ),
          ],
        ),
      ),
    );
  }
}

class NotifyTile extends StatefulWidget {
  const NotifyTile(
      {Key key, this.name, this.time, this.count, this.message, this.path})
      : super(key: key);

  final String path, name, message, count, time;

  @override
  _NotifyTileState createState() => _NotifyTileState();
}

class _NotifyTileState extends State<NotifyTile> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        ListTile(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => OtherProfile(name:widget.name,username: widget.message,Follow: follow,)));
          },
          // dense: true,
          contentPadding: EdgeInsets.only(left: 18, right: 18),
          leading: SvgPicture.asset("assets/new_icons/noti.svg"),
          title: Text(
            widget.name,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: 'Roboto',
                color: Color(0xFF000000)),
          ),
          //   title: Text('Jerome Bell',
          //   // style: TextStyle(fontFamily: 'Poppins',fontSize: 16)
          // ),
          subtitle: Text(
            widget.message,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Inter',
                color: Color(0xFF828282)),
          ),
          // trailing: InkWell(
          //   onTap: () {
          //     setState(() {
          //       follow = !follow;
          //     });
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(8)),
          //       border: !follow?Border.all(width: 1, color: Color(0xFF000000)):null,
          //       color: follow? Color(0xFF3550A3):Color(0xFFFFFFFF)
          //     ),
          //     height: 32,
          //     // width: _width / 2 - 15,
          //     width: 80,
          //     // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

          //     child: Center(
          //       child: Text(follow?"Undo":"Remove",
          //           style: TextStyle(
          //               color: !follow?Colors.black:Colors.white,
          //               fontFamily: 'Inter',
          //               fontSize: 14.0,
          //               letterSpacing: 0.15,
          //               fontWeight: FontWeight.w400)),
          //     ),
          //   ),
          // ),
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          height: 1.5,
          color: Color(0xFFE8E8E8),
        ),
      ],
    );
  }
}
