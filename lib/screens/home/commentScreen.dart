import 'package:fireauth/screens/home/post.dart';
import 'package:fireauth/screens/home/search_screen.dart';
import 'package:fireauth/screens/home/stock_info.dart';
import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/feed_post.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:fireauth/widgets/search_bar.dart';
import 'package:fireauth/widgets/textformfield.dart';
import 'package:fireauth/widgets/trending_stock.dart';
import 'package:fireauth/widgets/watchListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:english_words/english_words.dart' as english_words;
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class commentScreen extends StatefulWidget {
  commentScreen({Key key, this.post}) : super(key: key);

  final Feed_post post;

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<commentScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController commentController = TextEditingController();
  bool _isLoading = false;
  bool _isSending = false;

  Widget commentFormfield() {
    return CustomTextField(
      // icon: Icons.send,
      // initVal: widget.forEdit ? null : oldAge.toString(),
      keyboardType: TextInputType.text,
      obscureText: false,
      max: 1,
      textEditingController: commentController,
      // icon: Icons.lock,
      hint: "Comment your reply",
    );
  }

  Future<void> _submit(String id, String text) async {
    setState(() {
      _isSending = true;
    });

    try {
      print("text is $text and id is $id");
      await Provider.of<UserAuth>(context, listen: false).comment(text, id);
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
    setState(() {
      _isSending = false;
    });
  }

  Future<void> getComment(String id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      print("id is $id");
      // await Provider.of<UserAuth>(context, listen: false).comment(text, id);
      await Provider.of<UserAuth>(context, listen: false).getcomment(id);

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
    setState(() {
      _isLoading = false;
    });
  }

  void initState() {
    getComment(widget.post.postId);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' ',
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
      
      body: 
          SingleChildScrollView(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                widget.post,
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      Container(
                        width: 270,
                        // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: commentFormfield(),
                      ),
                      GestureDetector(
                          onTap: () {
                            String text = commentController.text;
                            print(text);
                            _submit(widget.post.postId, text);
                          },
                          child: _isSending
                              ? Container(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(),
                                )
                              : Icon(Icons.send,color: Colors.blue,size: 40,))
                    ],
                  ),
                ),
            _isLoading?Center(
              child: Container(
                height: 100,child: Center(child: CircularProgressIndicator()),
              ),
            ):SizedBox(height: 1,),

              ],

            ),
          ),
      backgroundColor: Color(0xFFFFFFFF),
      resizeToAvoidBottomPadding: false,
    );
  }
}
