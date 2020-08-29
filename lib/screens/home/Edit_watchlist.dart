import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/feed_post.dart';
import 'package:flutter/material.dart';

class EditWatchList extends StatefulWidget {
  EditWatchList({Key key, }) : super(key: key);


  @override
  _EditWatchListState createState() => _EditWatchListState();
}

class _EditWatchListState extends State<EditWatchList> {
  

  
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
            title: 'Edit Watchlist',
          )),
      
      body: null,
    );
  }
}
