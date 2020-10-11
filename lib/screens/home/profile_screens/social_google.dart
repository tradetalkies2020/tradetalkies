
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Social_google extends StatefulWidget {
  Social_google({
    Key key,
  }) : super(key: key);

  @override
  _Social_googleState createState() => _Social_googleState();
}

class _Social_googleState extends State<Social_google> {
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
            isProfile: false,

            elevation: 2.0,
            color: Colors.white,
            title: 'Social connection',
          )),
      
      body: null,
    );
  }
}




