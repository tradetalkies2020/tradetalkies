import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';


class searchScreen extends StatefulWidget {
  searchScreen({
    Key key,
  }) : super(key: key);

  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
 
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        title: Text(
          'Explore',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData.fallback(),
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
        //                       builder: (context) => searchScreen(
        //                             firstVisit: true,forEdit: true,
        //                           )));
        //             },
        //             child: Text('Edit info',
        //                 style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
        //           ),
        //         )
        //       ],
      ),
      resizeToAvoidBottomPadding: false,
      body: null,
    );
  }
}
