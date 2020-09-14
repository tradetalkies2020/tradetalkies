import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/feed_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class StockInfo extends StatefulWidget {
  StockInfo({Key key, this.name, this.code,this.fromSearch}) : super(key: key);

  final name, code;
  final bool fromSearch;

  @override
  _StockInfoState createState() => _StockInfoState();
}

class _StockInfoState extends State<StockInfo> {
  bool _isWatched = false;
  List filter_type = ['1D', '5D', '1M', '3M', '6M', '1Y', '2Y', '3Y'];
  var data = [0.0,1.0,1.5,2.0,0.0,0.0,-0.5,-1.0,-0.5,-0.0,-0.0];
  // var data = [0.0,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5];

  List<bool> selected_feed = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List imageAssets = [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ];

  buildItem(BuildContext context, String value, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selected_feed.setAll(
              0, [false, false, false, false, false, false, false, false]);
          // print(selected_feed);
          selected_feed[index] = true;
          // print(selected_feed);
        });
      },
      child: Container(
        margin: EdgeInsets.all(7),

        // padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: selected_feed[index]
              ? Color(0xFF3d96ff).withOpacity(0.1)
              : Color(0xFFFFFFFF).withOpacity(0.1),
          border: selected_feed[index]
              ? Border.all(color: Color(0xFF3D96FF), width: 1)
              : Border.all(color: Color(0xFFD5D5D5), width: 1),
        ),

        // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        width: 50,

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:widget.fromSearch?null: new PreferredSize(
          preferredSize:
              Size.fromHeight(58.0), // Change the height of the appbar
          child: CustomAppbar(
            isHome: false,
            leading: true,
            show_icon: false,
            elevation: 2.0,
            color: Colors.white,
            title: widget.name,
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
      //   actioans: widget.forEdit
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
      //                         builder: (context) => StockInfo(
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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.code,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: _isWatched
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                ),
                          onPressed: () {
                            setState(() {
                              _isWatched = !_isWatched;
                            });
                          }),
                      Text(
                        _isWatched ? '' : 'Watchlist',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    '38,434.34',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '+214.32 (+0.56%)',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF219653)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.all(8),
              height: 144,
              // color: Colors.yellow,
              child: new Sparkline(
                // sharpCorners: true,
                data: data,
                fillMode: FillMode.below,
                fillGradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFc5dfcf),
                  // Color(0xFFeff7f2)
                  Color(0xFFfcfdfd)
                  ]),
                lineWidth: 1.0,
                lineColor: Color(0xFF569862),
                ),),
            Container(
              // color: Colors.red,
              padding: EdgeInsets.only(right: 8.0),
              margin: EdgeInsets.only(left: 15),

              height: 43,
              child: ListView.builder(
                itemCount: filter_type.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return buildItem(context, filter_type[index], index);
                },
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              color: Color(0xFFF1F1F1),
              height: 4,
            ),
            SizedBox(
              height: 10,
            ),

            Feed_post(
              name: 'Manikanth',
              time: '2mins ago',
              text:
                  'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              imageAsset: null,
              isPost: false,
              isLiked: false,
                hasPhoto: true,
              likes: 0,comment: 0,repost: 0,forComment: false,

            ),
            Divider(),

            Feed_post(
              name: 'sarthak',
              time: '4mins ago',
              text:
                  'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              imageAsset: imageAssets,
              isPost: false,
              isLiked: false,
                hasPhoto: true,
              likes: 0,comment: 0,repost: 0,forComment: false,

            ),

            Divider(),
            Feed_post(
              name: 'AmanKumar',
              time: '6mins ago',
              text:
                  'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              imageAsset: null,
              isPost: false,
              isLiked: false,
                hasPhoto: true,
              likes: 0,comment: 0,repost: 0,forComment: false,

            ),

            Divider(),
            Feed_post(
              name: 'Manikanth',
              time: '2mins ago',
              text:
                  'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              imageAsset: imageAssets,
              isPost: false,
              isLiked: false,
                hasPhoto: true,
              likes: 0,comment: 0,repost: 0,forComment: false,

            ),

            Divider(),
            Feed_post(
              name: 'Manikanth',
              time: '2mins ago',
              text:
                  'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              imageAsset: imageAssets,
              isPost: false,
              isLiked: false,
                hasPhoto: true,
              likes: 0,comment: 0,repost: 0,forComment: false,
            ),
          ],
        ),
      ),
    );
  }
}
