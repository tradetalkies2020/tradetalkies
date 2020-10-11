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

class Rooms extends StatefulWidget {
  Rooms({Key key}) : super(key: key);

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  buildMyRooms(BuildContext context) {
    return MyRoomTile(
      name: 'Indian stock stuffs and gui..',
      path: 'assets/images/avatar.png',
      message: 'Great insights thanks!!',
      time: '11:11',
      count: '2',
    );
  }

  buildFreeRooms(BuildContext context) {
    return FreeRoomTile(
      name: 'NSE stock talks',
      path: 'assets/images/avatar.png',
      message: '120 Members joined',
      time: '11.11',
      count: '1',
    );
  }

  buildPaidRooms(BuildContext context) {
    return PaidRoomTile(
      name: 'NSE stock talks',
      path: 'assets/images/avatar.png',
      message: '120 Members joined',
      time: '11.11',
      count: '1',
    );
  }

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      // Center(child: Icon(Icons.cloud, size: 64.0, color: Colors.teal)),
      ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return buildMyRooms(context);
        },
      ),
      ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return buildFreeRooms(context);
        },
      ),
      ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return buildPaidRooms(context);
        },
      ),
    ];
    final _kTabs = <Tab>[
      Tab(
        child: Text(
          "My Rooms",
          style: TextStyle(fontSize: 14, fontFamily: 'Inter'),
        ),
      ),
      Tab(
        child: Text(
          "Free Rooms",
          style: TextStyle(fontSize: 14, fontFamily: 'Inter'),
        ),
      ),
      Tab(
        child: Text(
          "Paid Rooms",
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
        //                         builder: (context) => Rooms(
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
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xFFF0F0F0),
              ),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              width:
                  _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 35,
                    ),
                    SizedBox(
                      width: 6,
                    ),

                    Text(
                      'Search/Explore',
                      style: TextStyle(
                          // height: 1.3,
                          fontFamily: 'Inter',
                          fontSize: 15,
                          letterSpacing: 0.2,
                          color: Color(0xff000000).withOpacity(0.4)),
                    )
                    // TextFormField(

                    //   decoration: InputDecoration(
                    //     border: InputBorder.none,
                    //     hintText: 'Search/Explore',
                    // hintStyle: TextStyle(
                    //     // height: 1.3,
                    //     fontFamily: 'Inter',
                    //     fontSize: 14,
                    //     color: Color(0xff000000).withOpacity(0.6)))
                    // )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TabBar(
              tabs: _kTabs,
              indicatorColor: Color(0xFF3550A3),
              labelColor: Color(0xFF3550A3),
              unselectedLabelColor: Color(0xFF000000),
            ),
            // AppBar(
            //   elevation: 2,

            // ),
            Container(
              height: _height - 260,
              // width: 500,
              child: TabBarView(
                children: _kTabPages,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFFFFFFF),
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Icon(
            Icons.add,
            size: 28,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF3550A3),
          onPressed: () {
            // _auth.signOut();
            // Navigator.pop(context);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => post()));
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            "Create Room",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            // textAlign: TextAlign.left,
                          ),
                          // SizedBox(height: 20),
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.only(right:20),
                            
                            title: Text("Free Room",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000))),
                            subtitle: Text('Any user can join the room',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    color: Color(0xFF828282))),
                                    trailing: Icon(Icons.keyboard_arrow_right,color:Colors.black,size: 25,),
                          ),
                          Container(
          height: 2,
          color: Color(0xFFE9E9E9),
        ),
        // hhhbhb
        ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.only(right:20),
                            
                            title: Text("Paid Room",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF000000))),
                            subtitle: Text('Only paid user can join the room',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    color: Color(0xFF828282))),
                                    trailing: Icon(Icons.keyboard_arrow_right,color:Colors.black,size: 25,),
                          ),

                          
                          // SizedBox(height: 20),
                          
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                });
              },

              // builder: (context) =>
            );
          },
        ),
      ),
    );
  }
}

class FreeRoomTile extends StatefulWidget {
  const FreeRoomTile(
      {Key key, this.name, this.time, this.count, this.message, this.path})
      : super(key: key);

  final String path, name, message, count, time;

  @override
  _FreeRoomTileState createState() => _FreeRoomTileState();
}

class _FreeRoomTileState extends State<FreeRoomTile> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        ListTile(
          onTap: () {},
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
                  border: !follow
                      ? Border.all(width: 1, color: Color(0xFF000000))
                      : null,
                  color: follow ? Color(0xFF3550A3) : Color(0xFFFFFFFF)),
              height: 32,
              // width: _width / 2 - 15,
              width: 80,
              // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

              child: Center(
                child: Text(follow ? "Joined" : "Join",
                    style: TextStyle(
                        color: !follow ? Colors.black : Colors.white,
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

class MyRoomTile extends StatefulWidget {
  const MyRoomTile(
      {Key key, this.name, this.time, this.count, this.message, this.path})
      : super(key: key);

  final String path, name, message, count, time;

  @override
  _MyRoomTileState createState() => _MyRoomTileState();
}

class _MyRoomTileState extends State<MyRoomTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        ListTile(
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
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.time,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    color: Color(0xFF4F4F4F)),
              ),
              SizedBox(
                height: 8,
              ),
              Material(
                elevation: 0.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 21.0,
                  width: 21.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFF3550A3)),
                  child: Center(
                    child: Text(widget.count,
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              )
            ],
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

class PaidRoomTile extends StatefulWidget {
  const PaidRoomTile(
      {Key key, this.name, this.time, this.count, this.message, this.path})
      : super(key: key);

  final String path, name, message, count, time;

  @override
  _PaidRoomTileState createState() => _PaidRoomTileState();
}

class _PaidRoomTileState extends State<PaidRoomTile> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        ListTile(
          onTap: () {},
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
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: !follow
                      ? Border.all(width: 1, color: Color(0xFF000000))
                      : null,
                  color: Color(0xFFFFFFFF)),
              height: 32,
              // width: _width / 2 - 15,
              width: 80,
              // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),

              child: Center(
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
                // child: Text(follow ? "Joined" : "Join",
                //     style: TextStyle(
                //         color: !follow ? Colors.black : Colors.white,
                //         fontFamily: 'Inter',
                //         fontSize: 14.0,
                //         letterSpacing: 0.15,
                //         fontWeight: FontWeight.w400)),
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
