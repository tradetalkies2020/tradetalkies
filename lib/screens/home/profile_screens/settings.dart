import 'package:fireauth/screens/home/profile_screens/notifications.dart';
import 'package:fireauth/screens/home/profile_screens/password.dart';
import 'package:fireauth/screens/home/profile_screens/social.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settings extends StatefulWidget {
  Settings({
    Key key,
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
            isProfile: false,

            title: 'Settings',
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
      //                         builder: (context) => Settings(
      //                               firstVisit: true,forEdit: true,
      //                             )));
      //               },
      //               child: Text('Edit info',
      //                   style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
      //             ),
      //           )
      //         ],
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height:15),
          Custom_setting_item(icon: "assets/new_icons/bell.svg", name: 'Notifications',index: 1,),
          Divider(height: 30.0,),
          Custom_setting_item(icon: "assets/new_icons/key.svg", name: 'Password',index: 2,),
          Divider(height: 30.0,),

          Custom_setting_item(icon: "assets/new_icons/users.svg", name: 'Social Connections',index: 3,),
          Divider(height: 30.0,),


        ],
      ),
    );
  }
}

class Custom_setting_item extends StatefulWidget {
  final String name;
  final String icon;
  final int index;

  const Custom_setting_item({Key key, this.name, this.icon,this.index}) : super(key: key);

  @override
  _Custom_setting_itemState createState() => _Custom_setting_itemState();
}

class _Custom_setting_itemState extends State<Custom_setting_item> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if(widget.index==1){
           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Notifications()));

        }
        if(widget.index==2){
           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Password()));

        }
        if(widget.index==3){
           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Social_Connect()));

        }
      },
      dense: true,
      // contentPadding: EdgeInsets.all(5),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(widget.icon),
        // child: Image.asset(
        //   widget.icon,
        //   fit: BoxFit.contain,
        //   width: 22,
        //   // color: Colors.black,
        //   height: 22,
        //   // color: pageIndex == 0
        //   //     ? Colors.blue
        //   //     : Theme.of(context).hintColor,
        // ),
      ),
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

