import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  Help({
    Key key,
  }) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  String rule1 =
      'I didnt get my revised earnings and it is not displaying the proper one, So please look into it. I didnt get my revised earnings and it is not displaying the proper one, So please look into it.';
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
            title: 'Help',
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
      //                         builder: (context) => Help(
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
            SizedBox(height: 10),
            ExpansionTile(
              // backgroundColor: Colors.yellow,
              title: Text('Room Rule',style: TextStyle(fontFamily: 'Inter',fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xFF221E22))),
              children: <Widget>[Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(rule1,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,fontFamily: 'Inter',height:1.7),),
              )],
            ),
            Divider(height:1.0),
            ExpansionTile(
              // backgroundColor: Colors.yellow,
              title: Text('Stock market prices',style: TextStyle(fontFamily: 'Inter',fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xFF221E22))),
              children: <Widget>[Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(rule1,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,fontFamily: 'Inter',height:1.7),),
              )],
            ),
            Divider(height:1.0),

            ExpansionTile(
              // backgroundColor: Colors.yellow,
              title: Text('Room post rules',style: TextStyle(fontFamily: 'Inter',fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xFF221E22))),
              children: <Widget>[Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(rule1,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,fontFamily: 'Inter',height:1.7),),
              )],
            ),
            Divider(height:1.0),

            ExpansionTile(
              // backgroundColor: Colors.yellow,
              title: Text('Stock market prices',style: TextStyle(fontFamily: 'Inter',fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xFF221E22))),
              children: <Widget>[Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(rule1,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,fontFamily: 'Inter',height:1.7),),
              )],
            ),
            Divider(height:1.0),

            ExpansionTile(
              // backgroundColor: Colors.yellow,
              title: Text('Room post rules',style: TextStyle(fontFamily: 'Inter',fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xFF221E22))),
              children: <Widget>[Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(rule1,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,fontFamily: 'Inter',height:1.7),),
              )],
            ),
            Divider(height:1.0),


            
          ],
        ),
      ),
    );
  }
}
