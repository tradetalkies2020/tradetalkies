import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';


class Notifications extends StatefulWidget {
  Notifications({
    Key key,
  }) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _plikes = true;
  bool _pmentions = false;
  bool _pdirect = true;
  bool _pfollows = false;
  bool _pwatchList = true;
  bool _prooms = false;
  bool _elikes = true;
  bool _ementions = false;
  bool _edirect = true;
  bool _efollows = false;
  bool _ewatchList = true;
  bool _erooms = false;


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
            title: 'Notification',
          )),
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(18.0),
              child: Text('Push Notifications',
                  style: TextStyle(
                    letterSpacing: 0.3,
                    color: Color(0xFF000000).withOpacity(0.5),
                    fontFamily: 'Inter',
                    fontSize: 16,
                  )),
            ),
            // SizedBox(height: 5.0,),
            ListTile(
              title: Text(
                'Likes',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._plikes,
                  onChanged: (bool value) {
                    setState(() {
                      this._plikes = value;
                      print(_plikes);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Mentions',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._pmentions,
                  onChanged: (bool value) {
                    setState(() {
                      this._pmentions= value;
                      print(_pmentions);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Direct Messages',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._pdirect,
                  onChanged: (bool value) {
                    setState(() {
                      this._pdirect = value;
                      print(_pdirect);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Follows',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._pfollows,
                  onChanged: (bool value) {
                    setState(() {
                      this._pfollows = value;
                      print(_pfollows);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Watchlist Trending',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._pwatchList,
                  onChanged: (bool value) {
                    setState(() {
                      this._pwatchList = value;
                      print(_pwatchList);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Rooms',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._prooms,
                  onChanged: (bool value) {
                    setState(() {
                      this._prooms = value;
                      print(_prooms);
                    });
                  }),
            ),
            SizedBox(height:15),
            Container(
              height: 3.0,
              color: Color(0xFFF1F1F1),
            ),
            // SizedBox(height:5),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(18.0),
              child: Text('Email Notifications',
                  style: TextStyle(
                    letterSpacing: 0.3,
                    color: Color(0xFF000000).withOpacity(0.5),
                    fontFamily: 'Inter',
                    fontSize: 16,
                  )),
            ),
            // SizedBox(height: 5.0,),
            ListTile(
              title: Text(
                'Likes',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._elikes,
                  onChanged: (bool value) {
                    setState(() {
                      this._elikes = value;
                      print(_elikes);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Mentions',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._ementions,
                  onChanged: (bool value) {
                    setState(() {
                      this._ementions= value;
                      print(_ementions);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Direct Messages',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._edirect,
                  onChanged: (bool value) {
                    setState(() {
                      this._edirect = value;
                      print(_edirect);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Follows',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._efollows,
                  onChanged: (bool value) {
                    setState(() {
                      this._efollows = value;
                      print(_efollows);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Watchlist Trending',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._ewatchList,
                  onChanged: (bool value) {
                    setState(() {
                      this._ewatchList = value;
                      print(_ewatchList);
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Rooms',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              trailing: Switch(
                  value: this._erooms,
                  onChanged: (bool value) {
                    setState(() {
                      this._erooms = value;
                      print(_erooms);
                    });
                  }),
            ),
            SizedBox(height:15)

          ],
        ),
      ),
    );
  }
}
