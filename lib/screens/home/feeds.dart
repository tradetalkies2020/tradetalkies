import 'package:fireauth/screens/home/post.dart';
import 'package:fireauth/screens/home/search_screen.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/feed_post.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:fireauth/widgets/trending_stock.dart';
import 'package:fireauth/widgets/watchListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Feeds extends StatefulWidget {
  Feeds({
    Key key,this.profileUrl,this.postText,this.postName,this.postImages,this.isPost
  }) : super(key: key);

  final String postName, postText, profileUrl;
  List postImages;
  final bool isPost;

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  List feed_type = ['Trending', 'Watchlist', 'Following', 'Suggestions'];
  List<bool> selected_feed = [true, false, false, false];

  List imageAssets = [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ];
  buildItem(BuildContext context, String value, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selected_feed.setAll(0, [false, false, false, false]);
          // print(selected_feed);
          selected_feed[index] = true;
          // print(selected_feed);
        });
      },
      child: Container(
        margin: EdgeInsets.all(7),

        // padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: selected_feed[index]
              ? Color(0xFF3d96ff).withOpacity(0.1)
              : Color(0xFFa5a5a5).withOpacity(0.1),
          border: selected_feed[index]
              ? Border.all(color: Color(0xFF3D96FF), width: 1)
              : null,
        ),

        // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        width: index == 3 ? 110 : 90,

        // height: 42,
        child: Center(
          child: Text(
            value,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                letterSpacing: 0.4,
                color: selected_feed[index] ? Color(0xFF3D96FF) : Colors.black),
          ),
        ),
      ),
    );
  }

  bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              color: Colors.black,
            ));
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => searchScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFFF0F0F0),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: _large
                      ? _width - 45
                      : (_medium ? _width - 35 : _width - 25),
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
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                // color: Colors.red,
                padding: EdgeInsets.only(right: 8.0),
                margin: EdgeInsets.only(left: 15),

                height: 55,
                child: ListView.builder(
                  itemCount: feed_type.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildItem(context, feed_type[index], index);
                  },
                ),
              ),
              SizedBox(height: 10),

              // Container(
              //   height: 450,
              //   child: ListView.builder(
              //       itemCount: feed_type.length,
              //       scrollDirection: Axis.vertical,
              //       itemBuilder: (context, index) {
              //         return Feed_post();
              //       },
              //     ),
              // )

              widget.isPost?Feed_post(name:widget.postName,text: widget.postText,time: '1min ago',imageAsset: widget.postImages,imageUrl: widget.profileUrl,isPost: true,):SizedBox(height: 1,),
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
              ),
              Divider(),

              Feed_post(
                name: 'sarthak',
                time: '4mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
              ),

              Divider(),
              Feed_post(
                name: 'AmanKumar',
                time: '6mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
              ),

              Divider(),
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
              ),

              Divider(),
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFFFFFFFF),
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: SvgPicture.asset("assets/new_icons/edit.svg"),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          onPressed: () {
            // _auth.signOut();
            // Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => post()));
          },
        ));
  }
}
