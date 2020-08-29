import 'package:fireauth/screens/home/comment.dart';
import 'package:fireauth/screens/home/fullPostView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Feed_post extends StatefulWidget {
  const Feed_post({Key key, this.name, this.text, this.time,this.imageAsset}) : super(key: key);

  final String name, time, text;
  final List imageAsset;

  @override
  _Feed_postState createState() => _Feed_postState();
}

class _Feed_postState extends State<Feed_post> {
  // List imageAssets = [
  //   AssetImage('assets/images/avatar.png'),
  //   AssetImage('assets/images/avatar.png'),
  //   AssetImage('assets/images/avatar.png')
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.imageAsset==null?185:400,
      // color: Colors.lime,
      child: Column(
        children: <Widget>[
          Container(
            // color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Theme.of(context).accentColor,
                        child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png')),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text(widget.time,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(height: 15,),
                  // IconButton(icon: Icons.more_vert, onPressed: null)
                  // PopupMenuButton(itemBuilder: (List<PopupMenuEntry<dynamic>>){return;},)
                  // IconData(codePoint)
                  // (child: Icon(Icons.more_vert)),
                  Container(
                    // color: Colors.yellow,
                    // padding: EdgeInsets.only(left: 10),
                    // child: IconButton(icon: Icon(Icons.more_vert), onPressed: null,iconSize: 30,
                    // constraints: BoxConstraints(maxWidth: 35,maxHeight: 40),),
                    child: IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            context: context,
                            builder: (context) => Container(
                                  height: 250,
                                  // color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      BottomSheetItem(
                                        title: 'Share this Profile',
                                        icon: "assets/new_icons/comment.svg",
                                      ),
                                      BottomSheetItem(
                                        title:
                                            'Notify me when the user uploaded',
                                        icon: "assets/new_icons/bell.svg",
                                      ),
                                      BottomSheetItem(
                                        title: 'Block this account',
                                        icon: "assets/new_icons/comment.svg",
                                      ),
                                      BottomSheetItem(
                                        title: 'Report this account',
                                        icon: "assets/new_icons/error.svg",
                                      ),
                                    ],
                                  ),
                                ));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              // color: Colors.blue,
              margin: EdgeInsets.only(left: 76, right: 25),
              child: Text(
                widget.text,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    color: Color(0xFF282828),
                    height: 1.3),
              )),
          SizedBox(
            height: widget.imageAsset==null?2:15,
          ),
          widget.imageAsset==null?SizedBox(height: 5,):
          Container(
            height: 200,
            width: 277,
            margin: EdgeInsets.only(left: 76, right: 20),
            child: ListView.builder(
              itemCount: widget.imageAsset.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                     Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullpostView(image: widget.imageAsset[index],)));
                  },
                                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 200,
                    width: 264,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: widget.imageAsset[index], fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      // color: Colors.blue
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: widget.imageAsset==null?18:23,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/new_icons/like.svg",
                    height: 20,
                    width: 20,
                  ),
                  Text(
                    '  (34)',
                    style: TextStyle(fontSize: 14, fontFamily: 'Inter'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.push(
              context, MaterialPageRoute(builder: (context) => Comment(name: widget.name,)));
                    },
                                      child: SvgPicture.asset(
                      "assets/new_icons/comment.svg",
                      height: 20,
                      width: 25,
                    ),
                  ),
                  Text(
                    '  (04)',
                    style: TextStyle(fontSize: 14, fontFamily: 'Inter'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/new_icons/repost.svg",
                    height: 20,
                    width: 25,
                  ),
                  Text(
                    '  (03)',
                    style: TextStyle(fontSize: 14, fontFamily: 'Inter'),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BottomSheetItem extends StatefulWidget {
  const BottomSheetItem({Key key, this.icon, this.title}) : super(key: key);
  final String title, icon;

  @override
  _BottomSheetItemState createState() => _BottomSheetItemState();
}

class _BottomSheetItemState extends State<BottomSheetItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: SvgPicture.asset(widget.icon),
        child: widget.title == 'Share this Profile'
            ? Icon(
                Icons.share,
                color: Colors.black,
                size: 22,
              )
            : (widget.title == 'Block this account'
                ? Icon(
                    Icons.block,
                    color: Colors.black,
                    size: 22,
                  )
                : SvgPicture.asset(widget.icon)),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            fontFamily: 'Inter',
            color: Color(0xFF000000)),
      ),
    );
  }
}
