import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
class PassBook extends StatefulWidget {
  PassBook({
    Key key,
  }) : super(key: key);

  @override
  _PassBookState createState() => _PassBookState();
}

class _PassBookState extends State<PassBook> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  String referLink = 'SASIKUMAR187234';

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
          child: CustomAppbar(
            isHome: false,
            leading: true,
            show_icon: false,
            isProfile: false,
            elevation: 2.0,
            color: Colors.white,
            title: 'Coin passbook',
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
      //                         builder: (context) => PassBook(
      //                               firstVisit: true,forEdit: true,
      //                             )));
      //               },
      //               child: Text('Edit info',
      //                   style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
      //             ),
      //           )
      //         ],
      // ),
      body: Center(
        child: Text('No reward earned',style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 14,
                                letterSpacing: 0.15,
                                fontWeight: FontWeight.w400)),
      ),
    );
  }
}
