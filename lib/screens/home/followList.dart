import 'package:fireauth/screens/home/Edit_watchlist.dart';
import 'package:fireauth/screens/home/chatScreen.dart';
import 'package:fireauth/screens/home/otherProfile.dart';
import 'package:fireauth/screens/home/post.dart';
import 'package:fireauth/screens/home/search.dart';
import 'package:fireauth/screens/home/search_screen.dart';
import 'package:fireauth/screens/home/stock_info.dart';
import 'package:fireauth/screens/home/stocks_data.dart';
import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:fireauth/widgets/search_bar.dart';
import 'package:fireauth/widgets/trending_stock.dart';
import 'package:fireauth/widgets/watchListItem.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as english_words;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class FollowList extends StatefulWidget {
  FollowList({Key key, this.name}) : super(key: key);
  final String name;

  @override
  _FollowListState createState() => _FollowListState();
}

class _FollowListState extends State<FollowList> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  buildFollowers(BuildContext context) {
    return FollowTile(
      name: 'Gowthan krishna',
      path: 'assets/images/avatar.png',
      message: '@gowthankrish',
      time: '11.11',
      count: '1',
    );
  }

  buildFollowing(BuildContext context) {
    return FollowTile(
      name: 'Hariprasath',
      path: 'assets/images/avatar.png',
      message: '@gowthankrish',
      time: '11.11',
      count: '1',
    );
  }

  @override
  Widget build(BuildContext context) {
    List followers = [
      FollowTile(
        name: 'Gowthan krishna',
        path: 'assets/images/avatar.png',
        message: '@gowthankrish',
        time: '11.11',
        count: '1',
      ),
      FollowTile(
        name: 'Jerome Bell',
        path: 'assets/images/avatar.png',
        message: 'This stocks price is massive..',
        time: '11.11',
        count: '1',
      ),
      FollowTile(
        name: 'Gowthan krishna',
        path: 'assets/images/avatar.png',
        message: 'This stocks price is massive..',
        time: '11.11',
        count: '1',
      )
    ];
    final _kTabPages = <Widget>[
      // Center(child: Icon(Icons.cloud, size: 64.0, color: Colors.teal)),
      ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return buildFollowers(context);
        },
      ),
      ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return buildFollowing(context);
        },
      ),
    ];
    final _kTabs = <Tab>[
      Tab(
        child: Text(
          "Followers",
          style: TextStyle(fontSize: 14, fontFamily: 'Inter'),
        ),
      ),
      Tab(
        child: Text(
          "Following",
          style: TextStyle(fontSize: 14, fontFamily: 'Inter'),
        ),
      ),
    ];
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
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
          bottom: TabBar(
            tabs: _kTabs,
            indicatorColor: Color(0xFF3550A3),
            labelColor: Color(0xFF3550A3),
            unselectedLabelColor: Color(0xFF000000),
          ),
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
        ),
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
        //                         builder: (context) => FollowList(
        //                               firstVisit: true,forEdit: true,
        //                             )));
        //               },
        //               child: Text('Edit info',
        //                   style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
        //             ),
        //           )
        //         ],
        // ),
        body: TabBarView(
          children: _kTabPages,
        ),
        backgroundColor: Color(0xFFFFFFFF),
      ),
    );
  }
}

class FollowTile extends StatefulWidget {
  const FollowTile(
      {Key key, this.name, this.time, this.count, this.message, this.path})
      : super(key: key);

  final String path, name, message, count, time;

  @override
  _FollowTileState createState() => _FollowTileState();
}

class _FollowTileState extends State<FollowTile> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtherProfile(name:widget.name,username: widget.message,Follow: follow,)));
          },
          dense: true,
          contentPadding: EdgeInsets.only(left: 18, right: 18),
          leading: CircleAvatar(
            radius: 23,
            backgroundColor: Theme.of(context).accentColor,
            child: CircleAvatar(
                radius: 40, backgroundImage: AssetImage(widget.path)),
          ),
          title: Text(
            widget.name,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
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
          trailing: InkWell(
            onTap: () {
              setState(() {
                follow = !follow;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: !follow?Border.all(width: 1, color: Color(0xFF000000)):null,
                color: follow? Color(0xFF3550A3):Color(0xFFFFFFFF)
              ),
              height: 32,
              // width: _width / 2 - 15,
              width: 80,
              // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

              child: Center(
                child: Text(follow?"Following":"+ Follow",
                    style: TextStyle(
                        color: !follow?Colors.black:Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        letterSpacing: 0.15,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(left: 80),
          height: 1.5,
          color: Color(0xFFE8E8E8),
        ),
      ],
    );
  }
}
