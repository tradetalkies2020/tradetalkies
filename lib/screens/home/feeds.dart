import 'package:fireauth/screens/home/post.dart';
import 'package:fireauth/screens/home/search_screen.dart';
import 'package:fireauth/screens/home/stock_info.dart';
import 'package:fireauth/screens/splash_screen/splash_screen.dart';
import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/feed_post.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:fireauth/widgets/search_bar.dart';
import 'package:fireauth/widgets/trending_stock.dart';
import 'package:fireauth/widgets/watchListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:english_words/english_words.dart' as english_words;
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Feeds extends StatefulWidget {
  Feeds(
      {Key key,
      this.profileUrl,
      this.postText,
      this.postName,
      this.postImages,
      this.isPost,
      this.hasPhoto,
      this.postId})
      : super(key: key);

  final String postName, postText, profileUrl, postId;
  List postImages;
  final bool isPost, hasPhoto;

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  _MySearchDelegate _delegate;
  final List<String> kEnglishWords;
  List<String> stocks = ['ABC', 'def', 'qwerty'];
  List<String> codes = ['ABC', 'DEF', 'QWERTY'];
  List selectedFilter = [];
  int selectedRadio = 0;
  DateTime from, to;
  Future myFuture;
  List feeds;

  bool isfromSelected = false;
  bool istoSelected = false;
  // List comments;
  // Future myFuture;
  // int selectedRadio = 0;

  // setSelectedRadio(int val) {
  //   setState(() {
  //     selectedRadio = val;
  //   });
  // }

  _FeedsState()
      : kEnglishWords = List.from(Set.from(english_words.all))
          ..sort(
            (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
          ),
        super();

  @override
  void initState() {
    super.initState();
    // _test();
    _delegate = _MySearchDelegate(kEnglishWords, kEnglishWords);
    myFuture = getPosts(Index);
    // myFuture = getComment('5f5be2749ae7fe00171b88fd');
    // selectedRadio = 0;
  }

  Future getPosts(int index) async {
    // setState(() {
    //   _isLoading = true;
    // });

    try {
      // print("id is $id");
      // await Provider.of<UserAuth>(context, listen: false).comment(text, id);
      feeds =
          await Provider.of<UserAuth>(context, listen: false).getPosts(index);
      print(feeds);

      // setState(() {
      //   comments = comment;
      // });

      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return HomeScreen(
      //           fromPost: true,
      //           selectedIndex: 3,
      //           postImages: images,
      //           postName: name,
      //           postText: text,
      //           profileUrl: image,
      //           postId:id,
      //           hasPhoto: _isImageSelected ? true : false);
      //     },
      //   ),
      // );
      // Navigator.pop(context);
      // print("posted");
      Toast.show(
        "Completed",
        context,
        duration: Toast.LENGTH_LONG,
      );
    } catch (err) {
      print(err.toString());
      // Toast.show(
      //   "Could not post",
      //   context,
      //   duration: Toast.LENGTH_LONG,
      // );
    }

    // setState(() {
    //   _isLoading = false;
    // });
  }

  Future getFilerFeeds(
      int selectedRadio, DateTime from, DateTime to, int index) async {
    // setState(() {
    //   _isLoading = true;
    // });

    try {
      // print("id is $id");
      // await Provider.of<UserAuth>(context, listen: false).comment(text, id);
      feeds = await Provider.of<UserAuth>(context, listen: false)
          .getFilterPosts(selectedRadio, from, to, index);
      print(feeds[0]);
      if (feeds[0] == null) {
        print('yess');
        feeds = [];
        // print(feeds);
      }
      // setState(() {
      //   comments = comment;
      // });

      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return HomeScreen(
      //           fromPost: true,
      //           selectedIndex: 3,
      //           postImages: images,
      //           postName: name,
      //           postText: text,
      //           profileUrl: image,
      //           postId:id,
      //           hasPhoto: _isImageSelected ? true : false);
      //     },
      //   ),
      // );
      // Navigator.pop(context);
      // print("posted");
      Toast.show(
        "Completed",
        context,
        duration: Toast.LENGTH_LONG,
      );
    } catch (err) {
      print(err.toString());
      // Toast.show(
      //   "Could not post",
      //   context,
      //   duration: Toast.LENGTH_LONG,
      // );
    }

    // setState(() {
    //   _isLoading = false;
    // });
  }

  Future<void> _test() async {
    try {
      // print("text is $text and id is $id");
      DateTime ab = DateTime.now();
      print(ab);
      await Provider.of<UserAuth>(context, listen: false).feed(ab);
      print('done');
      // await Provider.of<UserAuth>(context, listen: false)
      //     .getcomment(widget.postId);

      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return HomeScreen(
      //           fromPost: true,
      //           selectedIndex: 3,
      //           postImages: images,
      //           postName: name,
      //           postText: text,
      //           profileUrl: image,
      //           postId:id,
      //           hasPhoto: _isImageSelected ? true : false);
      //     },
      //   ),
      // );
      // Navigator.pop(context);
      // print("posted");
      Toast.show(
        "Commented",
        context,
        duration: Toast.LENGTH_LONG,
      );
    } catch (err) {
      print(err.toString());
      // Toast.show(
      //   "Could not post",
      //   context,
      //   duration: Toast.LENGTH_LONG,
      // );
    }
  }

  List feed_type = ['All', 'Trending', 'Watchlist', 'Following', 'Suggestions'];
  List<bool> selected_feed = [true, false, false, false, false];
  bool isFilter = false;

  List imageAssets = [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ];
  int Index = 0;
  List<Widget> ac = [
    Feed_post(
      name: 'Manikanth',
      time: '2mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      isPost: false,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      forComment: false,
      hasPhoto: true,
    ),
    //   Divider(),

    Feed_post(
      name: 'sarthak',
      time: '4mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      isPost: false,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      hasPhoto: true,
      forComment: false,
    ),

    //Divider(),
    Feed_post(
      name: 'AmanKumar',
      time: '6mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      isPost: false,
      hasPhoto: true,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      forComment: false,
    ),

    //Divider(),
    Feed_post(
      name: 'Manikanth',
      time: '2mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      hasPhoto: true,
      isPost: false,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      forComment: false,
    ),

    //Divider(),
    Feed_post(
      name: 'Manikanth',
      time: '2mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      hasPhoto: true,
      isPost: false,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      forComment: false,
    ),
  ];

  List<Widget> sc = [
    Feed_post(
      name: 'Sahak',
      time: '2mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      hasPhoto: true,
      isPost: false,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      forComment: false,
    ),
    //   Divider(),

    Feed_post(
      name: 'syiyiyi',
      time: '4mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      hasPhoto: true,
      isPost: false,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      forComment: false,
    ),

    //Divider(),
    Feed_post(
      name: 'AmanKumar',
      time: '6mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      isPost: false,
      hasPhoto: true,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      forComment: false,
    ),

    //Divider(),
    Feed_post(
      name: 'Manikanth',
      time: '2mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      isPost: false,
      hasPhoto: true,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      forComment: false,
    ),

    //Divider(),
    Feed_post(
      name: 'Manikanth',
      time: '2mins ago',
      text:
          'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
      imageAsset: [
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png'),
        AssetImage('assets/images/avatar.png')
      ],
      isPost: false,
      isLiked: false,
      likes: 10,
      comment: 10,
      repost: 10,
      forComment: false,
      hasPhoto: true,
    ),
  ];

  buildItem(BuildContext context, String value, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selected_feed.setAll(0, [false, false, false, false, false]);
          // print(selected_feed);
          selected_feed[index] = true;
          // print(selected_feed);
          Index = index;
          myFuture = getPosts(Index);
        });
      },
      child: Container(
        margin: EdgeInsets.all(7),

        // padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: selected_feed[index]
              ? Color(0xFF3550A3).withOpacity(0.1)
              : Color(0xFFa5a5a5).withOpacity(0.1),
          border: selected_feed[index]
              ? Border.all(color: Color(0xFF3550A3), width: 1)
              : null,
        ),

        // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        width: index == 3 ? 110 : (index == 0 ? 60 : 90),

        // height: 42,
        child: Center(
          child: Text(
            value,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                letterSpacing: 0.4,
                color: selected_feed[index] ? Color(0xFF3550A3) : Colors.black),
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
                onTap: () async {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => searchScreen()));
                  final String selected = await showSearches<String>(
                    context: context,
                    delegate: _delegate,
                  );
                  if (selected != null) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You have selected the word: $selected'),
                      ),
                    );
                  }
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

                height: 50,
                child: ListView.builder(
                  itemCount: feed_type.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildItem(context, feed_type[index], index);
                  },
                ),
              ),
              // SizedBox(height: 10),
              Container(
                // color:Colors.yellow,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Index == 0 ? 'All Feeds' : '',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () {
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
                                  height: selectedRadio != 2 ? 320 : null,
                                  // color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: Text('Filter',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins'))),
                                      SizedBox(height: 15),
                                      ListTile(
                                        title: Text(
                                          'Last 1 hour',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              color: Color(0xFF000000)),
                                        ),
                                        trailing: Radio(
                                          toggleable: true,
                                          value: 1,
                                          groupValue: selectedRadio,
                                          activeColor: Colors.black,
                                          onChanged: (val) {
                                            print("Radio $val");
                                            set(() {
                                              selectedRadio = val;
                                              print(selectedRadio);
                                            });
                                          },
                                        ),
                                      ),
                                      // BottomSheetItem(
                                      //   title: 'Last 1 hour',
                                      //   value: 1,
                                      // ),
                                      ListTile(
                                        title: Text(
                                          'Custom dates',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              color: Color(0xFF000000)),
                                        ),
                                        trailing: Radio(
                                          toggleable: true,
                                          value: 2,
                                          groupValue: selectedRadio,
                                          activeColor: Colors.black,
                                          onChanged: (val) {
                                            print("Radio $val");
                                            set(() {
                                              selectedRadio = val;
                                              print(selectedRadio);
                                            });
                                          },
                                        ),
                                      ),
                                      selectedRadio == 2
                                          ? Container(
                                              // color: Colors.yellow,
                                              height: 80,
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime(
                                                                      2015),
                                                              lastDate: DateTime(
                                                                  DateTime.now()
                                                                          .year +
                                                                      1))
                                                          .then((value) {
                                                        print(value);
                                                        set(() {
                                                          from = value;
                                                          isfromSelected = true;
                                                        });
                                                      });
                                                    },
                                                    child: Container(
                                                      // margin: EdgeInsets.all(7),
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      // padding: EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                          // color: Colors.white,
                                                          // color: selected_feed[index]
                                                          //     ? Color(0xFF3550A3).withOpacity(0.1)
                                                          //     : Color(0xFFa5a5a5).withOpacity(0.1),
                                                          // border: selected_feed[index]
                                                          //     ? Border.all(color: Color(0xFF3550A3), width: 1)
                                                          //     : null,
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xFFE0E0E0),
                                                              width: 1)),

                                                      // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                      width: 130,

                                                      height: 45,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today,
                                                            color: Colors.black,
                                                          ),
                                                          Text(
                                                            isfromSelected
                                                                ? '${from.day}/${from.month}/${from.year}'
                                                                : 'From Date',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0.4,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime(
                                                                      2015),
                                                              lastDate: DateTime(
                                                                  DateTime.now()
                                                                          .year +
                                                                      1))
                                                          .then((value) {
                                                        print(value);
                                                        set(() {
                                                          to = value;
                                                          istoSelected = true;
                                                        });
                                                      });
                                                    },
                                                    child: Container(
                                                      // margin: EdgeInsets.all(7),
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      // padding: EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                          // color: Colors.white,
                                                          // color: selected_feed[index]
                                                          //     ? Color(0xFF3550A3).withOpacity(0.1)
                                                          //     : Color(0xFFa5a5a5).withOpacity(0.1),
                                                          // border: selected_feed[index]
                                                          //     ? Border.all(color: Color(0xFF3550A3), width: 1)
                                                          //     : null,
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xFFE0E0E0),
                                                              width: 1)),

                                                      // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                      width: 130,

                                                      height: 45,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today,
                                                            color: Colors.black,
                                                          ),
                                                          Text(
                                                            istoSelected
                                                                ? '${to.day}/${to.month}/${to.year}'
                                                                : 'To Date',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0.4,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(height: 1),
                                      ListTile(
                                        title: Text(
                                          'Last 7 days',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              color: Color(0xFF000000)),
                                        ),
                                        trailing: Radio(
                                          toggleable: true,
                                          value: 3,
                                          groupValue: selectedRadio,
                                          activeColor: Colors.black,
                                          onChanged: (val) {
                                            print("Radio $val");
                                            set(() {
                                              selectedRadio = val;
                                              print(selectedRadio);
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (selectedRadio == null) {
                                              isFilter = false;
                                            } else {
                                              isFilter = true;
                                              myFuture = getFilerFeeds(
                                                  selectedRadio,
                                                  from,
                                                  to,
                                                  Index);
                                            }
                                          });
                                          print(
                                              "selected radio is $selectedRadio");
                                          Navigator.pop(context);
                                        },
                                        // onTap: widget.forEdit ? _submit : null,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            color: selectedRadio != null
                                                ? Color(0xFF3550A3)
                                                : Color(0xFFABABAB),
                                          ),
                                          margin:
                                              EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          width: _large
                                              ? _width - 45
                                              : (_medium
                                                  ? _width - 35
                                                  : _width - 25),
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              "Apply",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                            },

                            // builder: (context) =>
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(7),

                              // padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                color: isFilter
                                    ? Color(0xFF3550A3).withOpacity(0.1)
                                    : Color(0xFFa5a5a5).withOpacity(0.1),
                                // color: Color(0xFFa5a5a5).withOpacity(0.1),
                                border: isFilter
                                    ? Border.all(
                                        color: Color(0xFF3550A3), width: 1)
                                    : null,
                              ),

                              // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              // width: index == 3 ? 110 : (index==0?60:90),
                              width: 80,
                              height: 30,

                              // height: 42,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                      "assets/new_icons/filter.svg"),
                                  Text('Filter',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 15,
                                          letterSpacing: 0.4,
                                          color: Colors.black)
                                      // color: selected_feed[index] ? Color(0xFF3550A3) : Colors.black),
                                      ),
                                ],
                              ),
                            ),
                            isFilter
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: InkWell(
                                      child: Material(
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          height: 18.0,
                                          width: 18.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color:
                                                  Colors.red.withOpacity(0.8)),
                                          child: Center(
                                            child: Text('1',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

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

              widget.isPost
                  ? Feed_post(
                      forComment: false,
                      postId: widget.postId,
                      hasPhoto: widget.hasPhoto,
                      name: widget.postName,
                      text: widget.postText,
                      time: '1min ago',
                      imageAsset: widget.hasPhoto ? widget.postImages : null,
                      imageUrl: widget.profileUrl,
                      isPost: true,
                      isLiked: false,
                      likes: 0,
                      comment: 0,
                      repost: 0,
                    )
                  : SizedBox(
                      height: 1,
                    ),
              //Divider(),
              // Index == 1
              //     ? FutureBuilder(
              //         // future: getComment(widget.post.postId),
              //         future: myFuture,
              //         builder: (ctx, snapshot) {
              //           if (snapshot.connectionState == ConnectionState.done) {
              //             return Column(
              //                 children: comments != null
              //                     ? List.generate(
              //                         comments.length,
              //                         (i) => Feed_post(
              //                               comment: 0,
              //                               forComment: true,
              //                               hasPhoto: false,
              //                               imageUrl: comments[i]['postedBy']
              //                                   ['imageUrl'],
              //                               isLiked: false,
              //                               isPost: false,
              //                               likes: 0,
              //                               name: comments[i]['postedBy']
              //                                   ['local']['username'],
              //                               imageAsset: null,
              //                               repost: 0,
              //                               text: comments[i]['comment'],
              //                               time: '1 min ago',
              //                             ))
              //                     : [
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text(
              //                             'No comments found till now..',
              //                             style: TextStyle(
              //                                 fontFamily: 'Inter',
              //                                 fontSize: 15,
              //                                 color: Colors.grey),
              //                           ),
              //                         )
              //                       ]);
              //           } else {
              //             return CircularProgressIndicator();
              //           }
              //         })
              //     : SizedBox(
              //         height: 1,
              //       ),

              // Column(
              //   children: Index == 0
              //       ? ac
              //       : (Index == 1 ? sc : (Index == 2 ? ac : sc)),
              // ),

              FutureBuilder(
                  // future: getComment(widget.post.postId),
                  future: myFuture,
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                          children: (feeds.isNotEmpty )
                              ? List.generate(feeds.length, (i) {
                                  List imagess = feeds[i]['images'];
                                  
                                  return Feed_post(
                                    comment: 0,
                                    forComment: false,
                                    hasPhoto: false,
                                    imageUrl: feeds[i]['userDetails']
                                        ['imageUrl'],
                                    // imageUrl: null,

                                    // isLiked: feeds[i]['liked'],
                                    isLiked: false,
                                    isPost: false,
                                    likes: 0,
                                    name: feeds[i]['userDetails']['local']
                                        ['username'],

                                    imageAsset: imagess==null?null:(imagess.isNotEmpty
                                        ? feeds[i]['images']
                                        : null),
                                    // imageAsset: null,
                                    repost: 0,
                                    text: feeds[i]['desc'],

                                    time: '1 min ago',
                                  );
                                })
                              : [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'No posts found till now..',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 15,
                                          color: Colors.grey),
                                    ),
                                  )
                                ]);
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),

              // Feed_post(
              //   name: 'Manikanth',
              //   time: '2mins ago',
              //   text:
              //       'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              //   imageAsset: imageAssets,
              //   isPost: false,
              //   isLiked: true,
              //   likes: 10,
              //   comment: 10,
              //   repost: 10,
              //   hasPhoto: true,
              //   forComment: false,
              // ),
              // //   Divider(),

              // Feed_post(
              //   name: 'sarthak',
              //   time: '4mins ago',
              //   text:
              //       'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              //   imageAsset: imageAssets,
              //   isPost: false,
              //   isLiked: true,
              //   likes: 10,
              //   comment: 10,
              //   repost: 10,
              //   hasPhoto: true,
              //   forComment: false,
              // ),

              // //Divider(),
              // Feed_post(
              //   name: 'AmanKumar',
              //   time: '6mins ago',
              //   text:
              //       'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              //   imageAsset: imageAssets,
              //   isPost: false,
              //   isLiked: true,
              //   likes: 10,
              //   comment: 10,
              //   repost: 10,
              //   hasPhoto: true,
              //   forComment: false,
              // ),

              // //Divider(),
              // Feed_post(
              //   name: 'Manikanth',
              //   time: '2mins ago',
              //   text:
              //       'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              //   imageAsset: imageAssets,
              //   isPost: false,
              //   isLiked: true,
              //   likes: 10,
              //   comment: 10,
              //   repost: 10,
              //   hasPhoto: true,
              //   forComment: false,
              // ),

              // //Divider(),
              // Feed_post(
              //   name: 'Manikanth',
              //   time: '2mins ago',
              //   text:
              //       'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
              //   imageAsset: imageAssets,
              //   isPost: false,
              //   isLiked: true,
              //   likes: 10,
              //   comment: 10,
              //   repost: 10,
              //   hasPhoto: true,
              //   forComment: false,
              // ),
            ],
          ),
        ),
        backgroundColor: Color(0xFFFFFFFF),
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: SvgPicture.asset("assets/new_icons/edit-3.svg"),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF3550A3),
          onPressed: () {
            // _auth.signOut();
            // Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => post()));
          },
        ));
  }
}

// Defines the content of the search page in `showSearch()`.
// SearchDelegate has a member `query` which is the query string.
class _MySearchDelegate extends SearchDelegates<String> {
  final List<String> _words;
  final List<String> _history;
  final List<String> _codes;

  _MySearchDelegate(List<String> words, List<String> codes)
      : _words = words,
        _codes = codes,
                _history = <String>['microsoft', 'apple', 'tesla', 'reliance'],

        super();

  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        color: Colors.black,
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
        this.close(context, null);
      },
    );
  }

  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    String code;
    for (int i = 0; i < _words.length; i++) {
      if (_words[i] == this.query) {
        code = _codes[i];
      }
    }
    return StockInfo(
      name: this.query,
      code: code,
      fromSearch: true,
    );
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _SuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic, color: Colors.white),
              onPressed: () {
                // this.query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

// Suggestions list widget displayed in the search page.
class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}

// class BottomSheetItem extends StatefulWidget {
//   const BottomSheetItem({Key key, this.value, this.title}) : super(key: key);
//   final String title;
//   final int value;

//   @override
//   _BottomSheetItemState createState() => _BottomSheetItemState();
// }

// class _BottomSheetItemState extends State<BottomSheetItem> {
//   @override
//   Widget build(BuildContext context) {
//     setSelectedRadio(int val) {
//       setState(() {
//         selectedRadio = val;
//         print(selectedRadio);
//       });
//     }

//     return ListTile(
//       title: Text(
//         widget.title,
//         style: TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 14,
//             fontFamily: 'Inter',
//             color: Color(0xFF000000)),
//       ),
//       trailing: Radio(
//         toggleable: true,
//         value: widget.value,
//         groupValue: selectedRadio,
//         activeColor: Colors.black,
//         onChanged: (val) {
//           print("Radio $val");
//           setSelectedRadio(val);
//         },
//       ),
//     );
//   }
// }
