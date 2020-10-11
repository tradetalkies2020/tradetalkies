import 'package:fireauth/screens/home/otherProfile.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/feed_post.dart';
import 'package:flutter/material.dart';

class EditWatchList extends StatefulWidget {
  EditWatchList({Key key, }) : super(key: key);


  @override
  _EditWatchListState createState() => _EditWatchListState();
}

class _EditWatchListState extends State<EditWatchList> {
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
          preferredSize:
              Size.fromHeight(58.0), // Change the height of the appbar
          child: CustomAppbar(
            isHome: false,
            leading: true,
            isProfile: false,

            show_icon: false,
            elevation: 2.0,
            color: Colors.white,
            title: 'Edit Watchlist',
          )),
      
      body: SingleChildScrollView(
        child: 
        Column(
          children: [
            SizedBox(height:16),
            WatchTile(
      name: 'AAPL',
      path: 'assets/images/avatar.png',
      message: 'Apple Inc',
      time: '11.11',
      count: '1',
    ),
    WatchTile(
      name: 'AAPL',
      path: 'assets/images/avatar.png',
      message: 'Apple Inc',
      time: '11.11',
      count: '1',
    ),WatchTile(
      name: 'AAPL',
      path: 'assets/images/avatar.png',
      message: 'Apple Inc',
      time: '11.11',
      count: '1',
    ),WatchTile(
      name: 'AAPL',
      path: 'assets/images/avatar.png',
      message: 'Apple Inc',
      time: '11.11',
      count: '1',
    ),WatchTile(
      name: 'AAPL',
      path: 'assets/images/avatar.png',
      message: 'Apple Inc',
      time: '11.11',
      count: '1',
    ),WatchTile(
      name: 'AAPL',
      path: 'assets/images/avatar.png',
      message: 'Apple Inc',
      time: '11.11',
      count: '1',
    ),
          ],
        ),
      ),
    );
  }
}

class WatchTile extends StatefulWidget {
  const WatchTile(
      {Key key, this.name, this.time, this.count, this.message, this.path})
      : super(key: key);

  final String path, name, message, count, time;

  @override
  _WatchTileState createState() => _WatchTileState();
}

class _WatchTileState extends State<WatchTile> {
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
          dense: true,
          contentPadding: EdgeInsets.only(left: 28, right: 28),
          // leading: CircleAvatar(
          //   radius: 23,
          //   backgroundColor: Theme.of(context).accentColor,
          //   child: CircleAvatar(
          //       radius: 40, backgroundImage: AssetImage(widget.path)),
          // ),
          title: Text(
            widget.name,
            style: TextStyle(
                fontWeight: FontWeight.w500,
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
                child: Text(follow?"Undo":"Remove",
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
          margin: EdgeInsets.only(left: 25,right:25),
          height: 1.5,
          color: Color(0xFFE8E8E8),
        ),
      ],
    );
  }
}
