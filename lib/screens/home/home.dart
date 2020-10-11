import 'package:fireauth/screens/home/chats.dart';
import 'package:fireauth/screens/home/feeds.dart';
import 'package:fireauth/screens/home/home_screen.dart';
import 'package:fireauth/screens/home/rooms.dart';
import 'package:fireauth/screens/home/stocks_data.dart';
import 'package:fireauth/services/auth/services.dart';
import 'package:flutter/material.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/screens/home/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
// importing auth screen
import '../../widgets/drawer.dart';

//
class HomeScreen extends StatefulWidget {
  HomeScreen(
      {Key key,
      this.selectedIndex,
      this.fromPost,
      this.postImages,
      this.postName,
      this.postText,
      this.profileUrl,this.hasPhoto,this.postId})
      : super(key: key);
  final int selectedIndex;
  final bool fromPost,hasPhoto;

  final String postName, postText, profileUrl,postId;
  List postImages;

  // HomeScreen({Key key}) : super(key: key);

  static const routeName = '/home-page';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int pageIndex = 0;
  

  // _HomeScreenState(int selectedIndex);

  // _HomeScreenState(selectedIndex);

  // _HomeScreenState(selectedIndex);

  // _HomeScreenState(int selectedPage);

 

  void _onChangePageIndex(index) {
    setState(() {
      pageIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Color(0xFF3550A3)Accent,
      //   title: Text(
      //     "Trade Talkies",
      //   ),
      // ),

      // drawer: AppDrawer(),
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(58.0), // Change the height of the appbar
        child: CustomAppbar(
          isHome: true,
          leading: false,
          show_icon: pageIndex == 0 ? true : false,
          isProfile:pageIndex==4?true:false,
          isOther:(pageIndex==1||pageIndex==2||pageIndex==3)?1:0,
          elevation: 0.0,
          color: pageIndex == 4 || pageIndex == 0
              ? Color(0xFFF6F6F8)
              : Colors.white70,
          title: pageIndex == 0
              ? 'Home'
              : (pageIndex == 1
                  ? 'Talkies'
                  : (pageIndex == 2
                      ? 'Chat'
                      : (pageIndex == 3 ? 'Feeds' : 'Profile'))),
        ),
      ),
      drawer: null,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onChangePageIndex,
        children: <Widget>[
          homeScreen(),
          Rooms(),
          Chats(),

          Feeds(
            isPost: widget.fromPost,
            postImages: widget.fromPost ? widget.postImages : null,
            postName: widget.fromPost ? widget.postName : null,
            postText: widget.fromPost ? widget.postText : null,
            profileUrl: widget.fromPost ? widget.profileUrl : null,
            hasPhoto:widget.fromPost?widget.hasPhoto:false,
            postId:widget.fromPost?widget.postId:null
          ),
          // Text('index= $pageIndex'),
          Profile(),
        ],
        // children: [
        // HomeScreen(
        //   userId: widget.user.uid,
        // ),
        // CategoryScreen(
        //   userId: widget.user.uid,
        // ),
        // CartScreen(
        //   user: widget.user,
        // ),
        // SearchScreen(
        //   userId: widget.user.uid,
        // ),
        // AccountScreen(),
        // ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              // icon: Image.asset(
              //   pageIndex == 0
              //       ? "assets/new_icons/home-filled.svg"
              //       : "assets/new_icons/home.svg",
              icon: SvgPicture.asset(pageIndex == 0
                  ? "assets/new_icons/home-filled.svg"
                  : "assets/new_icons/home.svg"),
              // fit: BoxFit.contain,
              // width: 20,
              // height: 20,
              // color: Colors.blue,
              // color: pageIndex == 0
              //     ? Color(0xFF3550A3)
              //     : Colors.black,
              // ),
              title: Container(
                padding: EdgeInsets.all(5.0),
                child: Text('Home',
                    style: TextStyle(fontSize: 10, fontFamily: 'Inter')),
              )),
          BottomNavigationBarItem(
              // icon: Image.asset(
              //   pageIndex == 1
              //       ? "assets/new_icons/airplay.svg"
              //       : "assets/new_icons/room-icon.svg",
              //   fit: BoxFit.contain,
              //   width: 23,
              //   height: 23,
              //   // color: pageIndex == 1
              //   //     ? Theme.of(context).iconTheme.color
              //   //     : Theme.of(context).hintColor,
              // ),
              icon: SvgPicture.asset(pageIndex == 1
                  ? "assets/new_icons/airplay.svg"
                  : "assets/new_icons/room-icon.svg"),
              // icon: Icon(Icons.airplay,color: pageIndex == 1
              //       ? Color(0xFF3550A3)
              //       : Colors.black,),
              title: Container(
                padding: EdgeInsets.all(5.0),
                child: Text('Talkies',
                    style: TextStyle(fontSize: 10, fontFamily: 'Inter')),
              )),
          BottomNavigationBarItem(
              // icon: Icon(Icons.chat_bubble_outline,color: pageIndex == 2
              //     ? Color(0xFF3550A3)
              //     : Colors.black,),
              // icon: Image.asset(
              //   pageIndex == 2
              //       ? "assets/new_icons/message-blue.svg"
              //       : "assets/new_icons/message-square.svg",
              //   fit: BoxFit.contain,
              //   width: 20,
              //   height: 20,
              //   // color: pageIndex == 2
              //   //     ? Theme.of(context).iconTheme.color
              //   //     : Theme.of(context).hintColor,
              // ),
              icon: SvgPicture.asset(pageIndex == 2
                  ? "assets/new_icons/message-blue.svg"
                  : "assets/new_icons/message-square.svg"),
              title: Container(
                padding: EdgeInsets.all(5.0),
                child: Text('Chat',
                    style: TextStyle(fontSize: 10, fontFamily: 'Inter')),
              )),
          BottomNavigationBarItem(
              // icon: Image.asset(
              //   pageIndex == 3
              //       ? "assets/new_icons/compass.svg"
              //       : "assets/new_icons/feed.svg",
              //   fit: BoxFit.contain,
              //   width: 20,
              //   height: 20,

              //   // color: Colors.black,
              //   // color: pageIndex == 3
              //   //     ? Color(0xFF3550A3)
              //   //     : Colors.black,
              // ),
              icon: SvgPicture.asset(pageIndex == 3
                  ? "assets/new_icons/compass.svg"
                  : "assets/new_icons/feed.svg"),
              title: Container(
                padding: EdgeInsets.all(5.0),
                child: Text('Feeds',
                    style: TextStyle(fontSize: 10, fontFamily: 'Inter')),
              )),
          BottomNavigationBarItem(
              // icon: Image.asset(
              //   pageIndex == 4
              //       ? "assets/new_icons/user-blue.svg"
              //       : "assets/new_icons/user-black.svg",
              //   fit: BoxFit.contain,
              //   width: 20,
              //   height: 20,
              //   // color: Colors.black,
              //   // color: pageIndex == 4
              //   //     ? Color(0xFF3550A3)
              //   //     : Colors.black,
              // ),
              icon: SvgPicture.asset(pageIndex == 4
                  ? "assets/new_icons/user-blue.svg"
                  : "assets/new_icons/user-black.svg"),
              title: Container(
                padding: EdgeInsets.all(5.0),
                child: Text('Profile',
                    style: TextStyle(fontSize: 10, fontFamily: 'Inter')),
              )),
        ],
        onTap: _onChangePageIndex,
        currentIndex: pageIndex,
        // fixedColor: Theme.of(context).primaryColor,
        // type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF3550A3),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
   
    _pageController =
        PageController(initialPage: widget.fromPost ? widget.selectedIndex : 0);
    pageIndex = widget.fromPost ? widget.selectedIndex : 0;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
