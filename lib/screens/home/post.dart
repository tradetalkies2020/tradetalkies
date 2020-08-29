import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';


class post extends StatefulWidget {
  post({
    Key key,
  }) : super(key: key);

  @override
  _postState createState() => _postState();
}

class _postState extends State<post> {
  List<Asset> images = List<Asset>();
  bool _isLoading = false;

  // buildItem(BuildContext context, Asset image) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0, left: 8),
  //     child: Container(
  //       height: 105.0,
  //       width: 160.0,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(0.0)),
  //         // image: cat.images.length > 0
  //         //     ? DecorationImage(
  //         //         image: NetworkImage(cat.images[0]), fit: BoxFit.cover)
  //         //     : null,
  //         image: image!=null?DecorationImage(image: ):null
  //       ),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(Radius.circular(0.0)),
  //           color: Colors.black.withOpacity(0.5),
  //         ),
  //         child: Center(
  //             child: AutoSizeText(
  //           cat.name,
  //           textAlign: TextAlign.center,
  //           overflow: TextOverflow.ellipsis,
  //           maxLines: 2,
  //           maxFontSize: 18,
  //           minFontSize: 12,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 18,
  //             letterSpacing: 0.2,
  //             fontWeight: FontWeight.w900,
  //           ),
  //         )),
  //       ),
  //     ),
  //   );
  // }

  buildItem(BuildContext context, Asset image, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AssetThumb(
              asset: image,
              width: 190,
              height: 130,
            ),
          ),
          Positioned(
            left: 4,
            top: 4,
            child: InkWell(
              onTap: () {
                setState(() {
                  images.removeAt(index);
                });
              },
              child: Material(
                elevation: 0.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFF000000).withOpacity(0.8)),
                  child: Center(
                    child: Icon(Icons.close, size: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
      print(images);
    });

    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
      );
    } on NoImagesSelectedException catch (e) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(e.message),
      ));
    } catch (e) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(e.message),
      ));
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      print(images);
    });
    // widget.updateAssetImages(resultList);
  }

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
          ' ',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w500),
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
        //                       builder: (context) => post(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment:  CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              // color: Colors.yellow,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: TextFormField(
                // minLines: 0,
                maxLines: 10,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type here to share \nyour views..',
                    hintStyle: TextStyle(
                        height: 1.3,
                        fontFamily: 'Inter',
                        fontSize: 26,
                        color: Color(0xff000000).withOpacity(0.3))),
              )),
          Column(
            children: <Widget>[
              Container(
                // color: Colors.red,
                padding: EdgeInsets.only(right: 8.0),
                height: 141,
                child: ListView.builder(
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildItem(context, images[index], index);
                  },
                ),
              ),
              Container(
                // color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.photo_library,
                            color: Colors.black,
                            size: 25,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            child: Text(
                              'Add image',
                              style:
                                  TextStyle(fontFamily: 'Inter', fontSize: 14),
                            ),
                            onTap: loadAssets,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isLoading = true;
                          });
                        },
                        child: Container(
                          // padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color(0xFF3D96FF),
                          ),
                          // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          width: 95,
                          height: 42,
                          child: Center(
                            child: _isLoading?Container(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2,)):Text(
                              "Post",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
