import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppbar extends StatefulWidget {
  final bool leading;
  final bool show_icon;
  final double elevation;
  final String title;
  final Color color;
  final bool isHome;
  const CustomAppbar(
      {Key key,
      this.leading,
      this.show_icon,
      this.elevation,
      this.title,
      this.color,
      this.isHome})
      : super(key: key);

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    // bool isAdmin = true;
    // const logoConfig = Logo;
    return AppBar(
      elevation: widget.elevation,
      backgroundColor: widget.color,
      automaticallyImplyLeading: widget.leading ? true : false,
      iconTheme: IconThemeData.fallback(),

      // centerTitle:true,
      // leading: widget.leading
      //     ? Builder(
      //         builder: (context) => IconButton(
      //           splashColor: Colors.transparent,
      //           highlightColor: Colors.transparent,
      //           // icon: ImageIcon(
      //           //   AssetImage("assets/icons/dashboard.png"),
      //           //   size: 18.0,
      //           //   color: Colors.white,
      //           // ),
      //           icon: new Icon(
      //             Icons.arrow_back,
      //             color: Colors.white,
      //           ),
      //           onPressed: () => Scaffold.of(context).openDrawer(),
      //         ),
      //       )
      //     : null,
      // title: Padding(
      //     padding: const EdgeInsets.only(left: 0.0),
      //     child: !logoConfig["isImage"]
      //         ? Text(
      //             logoConfig["title"],
      //             textAlign: TextAlign.center,
      //             style: new TextStyle(
      //               fontFamily: logoConfig["fontFamily"],
      //               color: Colors.white,
      //               fontWeight: FontWeight.bold,
      //               letterSpacing: 0.73,
      //               fontSize: 22.0,
      //             ),
      //           )
      //         : logoConfig["isAsset"]
      //             ? Image.asset(logoConfig["image"])
      //             : Image.network(logoConfig["image"])),
      title: Text(
        widget.title,
        style: widget.isHome?TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.bold):TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w500),
      ),

      actions: widget.show_icon
          ? <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                  ),
                  // icon: SvgPicture.asset("assets/new_icons/bell.svg"),
                  onPressed: () {
                    // Navigator.of(context).pushNamed("/notifications");
                  }),
            ]
          : null,
    );
  }
}
