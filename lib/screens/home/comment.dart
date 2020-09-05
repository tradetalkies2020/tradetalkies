import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Comment extends StatefulWidget {
  Comment({Key key, this.name, this.postId, this.profileImage})
      : super(key: key);
  final String name, profileImage, postId;

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  List<Asset> images = List<Asset>();
  bool _isLoading = false;
  TextEditingController textController = TextEditingController();

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    // List imageFiles = [];
    // String image, name;

    // if (_isImageSelected == false) {
    //   imageFiles = ['one'];
    // } else {
    //   for (int i = 0; i < images.length; i++) {
    //     final byteData = await images[i].getByteData();
    //     final tempFile =
    //         File("${(await getTemporaryDirectory()).path}/${images[i].name}");
    //     final file = await tempFile.writeAsBytes(
    //       byteData.buffer
    //           .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    //     );
    //     imageFiles.add(file);
    //   }
    // }

    // print(imageFiles);
    // String fileName = path.basename(imageFiles[0].path);
    // String fileName1 = path.basename(imageFiles[1].path);

    // print("filebase name is $fileName");

    final String text = textController.text;
    //text.replaceAllMapped(new RegExp(r'@'), (match) =>r'n' );

    print(text);
    // print(pickers);

    try {
      // imageFiles[0] = await MultipartFile.fromFile(imageFiles[0].path.toString(),
      //     filename: fileName, contentType: MediaType("image", "jpg"));
      // print(imageFiles);
      // imageFiles[1] = await MultipartFile.fromFile(imageFiles[1].path.toString(),
      //     filename: fileName1, contentType: MediaType("image", "jpg"));
      // print(imageFiles);

      await Provider.of<UserAuth>(context, listen: false)
          .comment(text, widget.postId);
          await Provider.of<UserAuth>(context, listen: false)
          .getcomment(widget.postId);
      // Map output = await Provider.of<UserAuth>(context, listen: false).getAge();
      // image = output['image'];
      // name = output['userName'];
      // print(image);
      // print('id is $id');

      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return HomeScreen(
      //           fromPost: true,
      //           selectedIndex: 3,
      //           postImages: images,
      //           postName: name,
      //           postText: text,
      //           profileUrl: image,
      //           postId:id,
      //           hasPhoto: _isImageSelected ? true : false);
      //     },
      //   ),
      // );
      Navigator.pop(context);
      // print("posted");
      Toast.show(
        "Commented",
        context,
        duration: Toast.LENGTH_LONG,
      );
    } catch (err) {
      print(err.toString());
      // Toast.show(
      //   "Could not post",
      //   context,
      //   duration: Toast.LENGTH_LONG,
      // );
    }
    setState(() {
      _isLoading = false;
    });
  }

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
        elevation: 2,
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
        //                       builder: (context) => Comment(
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(24, 0, 0, 0),
                          height: 74,
                          width: 2,
                          color: Color(0xFFC2C2C2)),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Theme.of(context).accentColor,
                        child: CircleAvatar(
                            radius: 40,
                            backgroundImage: widget.profileImage != null
                                ? NetworkImage(widget.profileImage)
                                : AssetImage('assets/images/avatar.png')),
                      )
                      // Padding(
                      //   padding: const EdgeInsets.all(25),
                      //   child: Text('Reply to ${widget.name}',
                      //       style: TextStyle(
                      //           fontFamily: 'Roboto',
                      //           fontSize: 15,
                      //           color: Color(0xFF282828),
                      //           letterSpacing: 0.2)),
                      // ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 25, 17),
                        child: Text('Reply to ${widget.name}',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: Color(0xFF282828),
                                letterSpacing: 0.2)),
                      ),
                      Container(
                        // color:Colors.lime,
                        height: 300,
                        width: 270,
                        child: Container(
                          // color:Colors.blue,

                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextFormField(
                            controller: textController,
                            // minLines: 0,
                            maxLines: 10,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    'Type here to comment on ${widget.name}’s post..',
                                hintStyle: TextStyle(
                                    height: 1.3,
                                    fontFamily: 'Inter',
                                    fontSize: 22,
                                    color: Color(0xff000000).withOpacity(0.3))),
                          ),
                        ),
                      )
                      //         Container(
                      //           height: 100,
                      // //           child: TextFormField(
                      //   // minLines: 0,
                      //   maxLines: 10,
                      //   style: TextStyle(
                      //     fontFamily: 'Inter',
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      //   decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       hintText: 'Type here to share \nyour views..',
                      //       hintStyle: TextStyle(
                      //             height: 1.3,
                      //             fontFamily: 'Inter',
                      //             fontSize: 26,
                      //             color: Color(0xff000000).withOpacity(0.3))),
                      // ),
                      // )
                    ],
                  )
                ],
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
                        onTap: _submit,
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
                            child: _isLoading
                                ? Container(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 2,
                                    ))
                                : Text(
                                    "Comment",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.normal),
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

// Container(
//               // color: Colors.yellow,
//               padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                           margin: EdgeInsets.fromLTRB(24, 0, 0, 0),
//                           height: 74,
//                           width: 2,
//                           color: Color(0xFFC2C2C2)),
//                       Padding(
//                         padding: const EdgeInsets.all(25),
//                         child: Text('Reply to ${widget.name}',
//                             style: TextStyle(
//                                 fontFamily: 'Roboto',
//                                 fontSize: 15,
//                                 color: Color(0xFF282828),
//                                 letterSpacing: 0.2)),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       CircleAvatar(
//                         radius: 25,
//                         backgroundColor: Theme.of(context).accentColor,
//                         child: CircleAvatar(
//                             radius: 40,
//                             backgroundImage:
//                                 AssetImage('assets/images/avatar.png')),
//                       ),
//                       Container(
//                         // color:Colors.lime,
//                         height: 300,
//                         width: 270,
//                         child: Container(
//                           // color:Colors.blue,

//                           margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
//                           child: TextFormField(
//                             // minLines: 0,
//                             maxLines: 10,
//                             style: TextStyle(
//                               fontFamily: 'Inter',
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText:
//                                     'Type here to comment on ${widget.name}’s post..',
//                                 hintStyle: TextStyle(
//                                     height: 1.3,
//                                     fontFamily: 'Inter',
//                                     fontSize: 22,
//                                     color: Color(0xff000000).withOpacity(0.3))),
//                           ),
//                         ),
//                       )
//                       //         Container(
//                       //           height: 100,
//                       // //           child: TextFormField(
//                       //   // minLines: 0,
//                       //   maxLines: 10,
//                       //   style: TextStyle(
//                       //     fontFamily: 'Inter',
//                       //     fontSize: 18,
//                       //     fontWeight: FontWeight.w500,
//                       //   ),
//                       //   decoration: InputDecoration(
//                       //       border: InputBorder.none,
//                       //       hintText: 'Type here to share \nyour views..',
//                       //       hintStyle: TextStyle(
//                       //             height: 1.3,
//                       //             fontFamily: 'Inter',
//                       //             fontSize: 26,
//                       //             color: Color(0xff000000).withOpacity(0.3))),
//                       // ),
//                       // )
//                     ],
//                   )
//                 ],
//               ))
