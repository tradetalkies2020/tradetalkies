import 'package:fireauth/screens/home/otherProfile.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/feed_post.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PriceAlert extends StatefulWidget {
  PriceAlert({Key key, }) : super(key: key);


  @override
  _PriceAlertState createState() => _PriceAlertState();
}

class _PriceAlertState extends State<PriceAlert> {
   double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
    

  

  
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      appBar: new PreferredSize(
          preferredSize:
              Size.fromHeight(58.0), // Change the height of the appbar
          child: AppBar(
        title: Text(
          'Price Alert',
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
        // actions: [ InkWell(child:
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //               // border: Border.all(color: Color(0xFF8E8E8E),style: BorderStyle.solid),
        //               borderRadius: BorderRadius.all(Radius.circular(5)),
        //               color: Color(0xFF3550A3),
        //             ),
           
        //     height: 10,
        //     width: 88,
        //     child:Center(child: Text('+ Price alert',style: TextStyle(fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w400),))
        //   ),
        // ),)],
        leading: InkWell(
          // focusColor: Colors.yellow,
          // highlightColor: Colors.yellow,
          // hoverColor: Colors.yellow,
          // splashColor: Colors.yellow,
          onTap: () {
            Navigator.maybePop(context);
          },
          child: Icon(Icons.close, size: 25, color: Colors.black),
        ),
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
        child: 
        Column(
          children: [
            SizedBox(height:25),
            InkWell(
              onTap: () async {
                // //   Navigator.push(context,
                // //       MaterialPageRoute(builder: (context) => AppBarSearchExample()));
                // final String selected = await showSearches<String>(
                //   context: context,
                //   delegate: _delegate,
                // );
                // if (selected != null) {
                //   Scaffold.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text('You have selected the word: $selected'),
                //     ),
                //   );
                // }
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
                        'Search stock name',
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
            )
            
    
          ],
        ),
      ),
    );
  }
}

