import 'dart:convert';
import 'dart:io';

import 'package:fireauth/screens/home/home.dart';
import 'package:fireauth/screens/home/stocks_data.dart';
import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
// import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class post extends StatefulWidget {
  post({
    Key key,
  }) : super(key: key);

  @override
  _postState createState() => _postState();
}

class _postState extends State<post> {
  List images = [];
  bool _isLoading = false;
  bool _isgettingData = false;
  final _textController = TextEditingController();
  bool _isImageSelected = false;
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  Stocks ab = Stocks();

  // Stocks ab = Stocks();

  List stocks = [];
  List<String> pickers = [];
  List<Map<String, dynamic>> finalStocks = [];
  // List<Map<String, dynamic>> readyStocks = [];
  void initState() {
    _getInfo();
    // readyStocks = ab.data;
  }

  Future<List> _getInfo() async {
    // setState(() {
    //   _isgettingData = true;
    // });
    try {
      print('trying');

      // setState(() {
      //   _isgettingData = true;
      // });

      stocks = await Provider.of<UserAuth>(context, listen: false).getData();
      ab.insertData(stocks);
      print(ab.data);
      print('sarthak');
      finalStocks = ab.data;
      print(finalStocks);

      // setState(() {
      //   print("done");

      //   _isgettingData = false;
      // });
      print('yes');
      // print('datarecieved is $stocks');
      // print(stocks.length);

      print('data recieved');

      // oldAge = output['age'];
      // oldIndustry = output['industry'];
      // imageUrl = output['image'];
      // print("age=$oldAge");
      // Info myinfo = new Info();
      // myinfo.image=

      // oldIndustry =
      //     await Provider.of<UserAuth>(context, listen: false).getIndustry();
      // print("industry=$oldIndustry");
    } catch (err) {
      print(err.toString());
      Toast.show(
        "error",
        context,
        duration: Toast.LENGTH_LONG,
      );
    }
    // setState(() {
    //   _isgettingData = false;
    // });
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
      images = [];
      print(images);
    });

    List resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
      );
      _isImageSelected = true;
      // print(resultList);
    } on NoImagesSelectedException catch (e) {
      print(e.message);
      _isImageSelected = false;

      // images = [];
      // Scaffold.of(context).showSnackBar(new SnackBar(
      //   content: new Text(e.message),

    } catch (e) {
      print(e.toString());
      _isImageSelected = false;
      // images == [];
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // images = resultList;
      // print(images);
      // _isImageSelected = false;
      if (_isImageSelected) {
        // _isImageSelected = false;
        images = resultList;
        print(images);
        // _isImageSelected = false;
        // } else {
        //   images = resultList;
        //   print(images);
        //   _isImageSelected = false;
        // }
      }
    });

    // print(images[0].identifier.)

    // final byteData = await images[0].getByteData();
    // final tempFile =
    //     File("${(await getTemporaryDirectory()).path}/${images[0].name}");
    // final file = await tempFile.writeAsBytes(
    //   byteData.buffer
    //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    // );

    // print(file);

    // final byteData = await resultList[0].getByteData();
    // final tempFile =
    //     File("${(await getTemporaryDirectory()).path}/${resultList[0].}");
    // final file = await tempFile.writeAsBytes(
    //   byteData.buffer
    //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    // );

    // print(file);
    // widget.updateAssetImages(resultList);
  }

  test() async {
    final byteData = await images[0].getByteData();
    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${images[0].name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    print(file);
    // final filepath =
    //     await FlutterAbsolutePath.getAbsolutePath(images[0].identifier);
    // print(filepath);
    // print("dd");
    // File tempfile = File(filepath);
    // print(tempfile);
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    List imageFiles = [];
    String image, name;

    if (_isImageSelected == false) {
      imageFiles = ['one'];
    } else {
      for (int i = 0; i < images.length; i++) {
        final byteData = await images[i].getByteData();
        final tempFile =
            File("${(await getTemporaryDirectory()).path}/${images[i].name}");
        final file = await tempFile.writeAsBytes(
          byteData.buffer
              .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
        );
        imageFiles.add(file);
      }
    }

    print(imageFiles);
    // String fileName = path.basename(imageFiles[0].path);
    // String fileName1 = path.basename(imageFiles[1].path);

    // print("filebase name is $fileName");

    final String text = key.currentState.controller.text;
    //text.replaceAllMapped(new RegExp(r'@'), (match) =>r'n' );

    print(text);
    print(pickers);

    try {
      // imageFiles[0] = await MultipartFile.fromFile(imageFiles[0].path.toString(),
      //     filename: fileName, contentType: MediaType("image", "jpg"));
      // print(imageFiles);
      // imageFiles[1] = await MultipartFile.fromFile(imageFiles[1].path.toString(),
      //     filename: fileName1, contentType: MediaType("image", "jpg"));
      // print(imageFiles);

      String id = await Provider.of<UserAuth>(context, listen: false)
          .post(text, imageFiles, pickers);
      Map output = await Provider.of<UserAuth>(context, listen: false).getAge();
      image = output['image'];
      name = output['userName'];
      // print(image);
      print('id is $id');

      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen(
                fromPost: true,
                selectedIndex: 3,
                postImages: images,
                postName: name,
                postText: text,
                profileUrl: image,
                postId:id,
                hasPhoto: _isImageSelected ? true : false);
          },
        ),
      );
      print("posted");
      Toast.show(
        "Posted",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: key,
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
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            // height: 100,
            child: _isgettingData
                ? Text('wait')
                : FlutterMentions(
                    onMentionAdd: (value) {
                      pickers.add("\$${value['display']}");
                      // pickers.add("\"abab\"");
                      print(pickers);
                      //setState(() {
                      //key.currentState.controller.text.replaceAllMapped(new RegExp('@'), (match) =>'n' );
                      //print(key.currentState.controller.text);
                      //});
                      //print(key.currentState.controller.text);
                    },
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type here to share \nyor views..',
                        hintStyle: TextStyle(
                            height: 1.3,
                            fontFamily: 'Inter',
                            fontSize: 26,
                            color: Color(0xff000000).withOpacity(0.3))),
                    key: key,
                    suggestionPosition: SuggestionPosition.Bottom,
                    maxLines: 5,
                    minLines: 1,
                    mentions: [
                      Mention(
                          trigger: '@',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          data: ab.data,
                          matchAll: false,
                          suggestionBuilder: (data) {
                            return Container(
                              // color: Colors.yellow,
                              // margin: EdgeInsets.all(5),

                              padding: EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: InkWell(
                                // onTap: () {
                                //   pickers.add(data['display']);
                                // },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data['full_name'],
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text('\$${data['display']}',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 14,
                                            color: Colors.grey)),
                                    Divider()
                                  ],
                                ),
                              ),
                            );
                          }),
                      // Mention(
                      //   trigger: '#',
                      //   disableMarkup: true,
                      //   style: TextStyle(
                      //     color: Colors.blue,
                      //   ),
                      //   data: [
                      //     {'id': 'reactjs', 'display': 'reactjs'},
                      //     {'id': 'javascript', 'display': 'javascript'},
                      //   ],
                      //   matchAll: true,
                      // )
                    ],
                  ),
          ),

          // Container(
          //     // color: Colors.yellow,
          //     padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
          //     child: TextFormField(
          //       // minLines: 0,
          //       maxLines: 10,
          //       controller: _textController,
          //       style: TextStyle(
          //         fontFamily: 'Inter',
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500,
          //       ),
          //       decoration: InputDecoration(
          //           border: InputBorder.none,
          //           hintText: 'Type here to share \nyour views..',
          //           hintStyle: TextStyle(
          //               height: 1.3,
          //               fontFamily: 'Inter',
          //               fontSize: 26,
          //               color: Color(0xff000000).withOpacity(0.3))),
          //     )),
          Column(
            children: <Widget>[
              _isImageSelected == false
                  ? SizedBox(
                      height: 1,
                    )
                  : Container(
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
                            color: Color(0xFF3550A3),
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
                                    "Post",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
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
