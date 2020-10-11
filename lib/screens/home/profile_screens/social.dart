
import 'package:fireauth/screens/home/profile_screens/social_fb.dart';
import 'package:fireauth/screens/home/profile_screens/social_google.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Social_Connect extends StatefulWidget {
  Social_Connect({
    Key key,
  }) : super(key: key);

  @override
  _Social_ConnectState createState() => _Social_ConnectState();
}

class _Social_ConnectState extends State<Social_Connect> {
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
            isProfile: false,

            color: Colors.white,
            title: 'Social connection',
          )),
     
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height:15),
          Custom_SocialItem( name: 'Google',index: 1,),
          Divider(height: 30.0,),
          // Container(height:2.0,color:Color(0xFFF1F1F1),),

          Custom_SocialItem( name: 'Facebook',index: 2,),
          Divider(height: 30.0,),


        ],
      ),
    );
  }
}

class Custom_SocialItem extends StatefulWidget {
  final String name;
  final int index;

  const Custom_SocialItem({Key key, this.name,this.index}) : super(key: key);

  @override
  _Custom_SocialItemState createState() => _Custom_SocialItemState();
}

class _Custom_SocialItemState extends State<Custom_SocialItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if(widget.index==1){
           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Social_google()));

        }
        if(widget.index==2){
           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Social_fb()));

        }
      },
      dense: true,
      // contentPadding: EdgeInsets.all(5),
      // leading: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Image.asset(
      //     widget.icon,
      //     fit: BoxFit.contain,
      //     width: 20,
      //     color: Colors.black,
      //     height: 20,
      //     // color: pageIndex == 0
      //     //     ? Colors.blue
      //     //     : Theme.of(context).hintColor,
      //   ),
      // ),
      title: Text(
        widget.name,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            fontFamily: 'Inter',
            color: Color(0xFF000000)),
      ),
      // subtitle: Text(widget.subtitle,style: TextStyle(fontFamily: 'Inter',fontSize: 14,color: Color(0xFF060606))),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 30,
      ),
    );
  }
}

