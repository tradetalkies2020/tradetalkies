import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class About_us extends StatefulWidget {
  About_us({
    Key key,
  }) : super(key: key);

  @override
  _About_usState createState() => _About_usState();
}

class _About_usState extends State<About_us> {
  String about_text1 = 'Get hassle-free solutions to all your queries at Tradetalkies Customer Care. Taking in regular feedback from all our users our customer success team has collated an exhaustive list of user queries, basis which we have built an in-app help and support section to meet all your needs.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
          preferredSize:
              Size.fromHeight(58.0), // Change the height of the appbar
          child: CustomAppbar(
            isHome: false,
            leading: true,
            show_icon: false,
            elevation: 2.0,
            color: Colors.white,
            title: 'About Us',
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
      //                         builder: (context) => About_us(
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                about_text1,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    height: 1.8),
              ),
              
            ),
            SizedBox(height:25.0),
            Padding(
              // padding: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.fromLTRB(16, 16,16, 16),
              child: Text(
                about_text1,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    height: 1.7),
              ),
              
            ),

          ],
        ),
      ),
    );
  }
}
