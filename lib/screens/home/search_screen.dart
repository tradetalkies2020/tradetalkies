import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'stocks_data.dart';

class searchScreen extends StatefulWidget {
  searchScreen({
    Key key,
  }) : super(key: key);

  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  Stocks ab = Stocks();
  String trigger = r'$';
  List stocks = [];
  

  void initState() {
    _getInfo();
  }

  Future<void> _getInfo() async {
    // setState(() {
    //   widget.forEdit ? _isLoading = false : _isLoading = true;
    // });
    try {
      stocks = await Provider.of<UserAuth>(context, listen: false).getData();
      print('yes');
      print('datarecieved is $stocks');
      // print(stocks.length);
      ab.insertData(stocks);

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
    //   setState(() {
    //     _isLoading = false;
    //   });
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
          'Explore',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.bold),
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
        //                       builder: (context) => searchScreen(
        //                             firstVisit: true,forEdit: true,
        //                           )));
        //             },
        //             child: Text('Edit info',
        //                 style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
        //           ),
        //         )
        //       ],
      ),
      // resizeToAvoidBottomPadding: false,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            child: Text('Get Text'),
            onPressed: () {
              print(key.currentState.controller.text);
            },
          ),
          Container(
            height: 100,
            child: FlutterMentions(
              key: key,
              suggestionPosition: SuggestionPosition.Bottom,
              maxLines: 5,
              minLines: 1,
              mentions: [
                Mention(
                    trigger: '@',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                    data: ab.data,
                    matchAll: true,
                    suggestionBuilder: (data) {
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                data['photo'],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: <Widget>[
                                Text(data['full_name']),
                                Text('@${data['display']}'),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                Mention(
                  trigger: '#',
                  disableMarkup: true,
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  data: [
                    {'id': 'reactjs', 'display': 'reactjs'},
                    {'id': 'javascript', 'display': 'javascript'},
                  ],
                  matchAll: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           RaisedButton(
//             child: Text('Get Text'),
//             onPressed: () {
//               print(key.currentState.controller.markupText);
//             },
//           ),
//           Container(
//             child: FlutterMentions(
//               key: key,
//               suggestionPosition: SuggestionPosition.Top,
//               maxLines: 5,
//               minLines: 1,
//               mentions: [
//                 Mention(
//                     trigger: '@',
//                     style: TextStyle(
//                       color: Colors.amber,
//                     ),
//                     data: [
//                       {
//                         'id': '61as61fsa',
//                         'display': 'fayeedP',
//                         'full_name': 'Fayeed Pawaskar',
//                         'photo':
//                             'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
//                       },
//                       {
//                         'id': '61asasgasgsag6a',
//                         'display': 'khaled',
//                         'full_name': 'DJ Khaled',
//                         'style': TextStyle(color: Colors.purple),
//                         'photo':
//                             'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
//                       },
//                       {
//                         'id': 'asfgasga41',
//                         'display': 'markT',
//                         'full_name': 'Mark Twain',
//                         'photo':
//                             'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
//                       },
//                       {
//                         'id': 'asfsaf451a',
//                         'display': 'JhonL',
//                         'full_name': 'Jhon Legend',
//                         'photo':
//                             'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
//                       },
//                     ],
//                     matchAll: false,
//                     suggestionBuilder: (data) {
//                       return Container(
//                         padding: EdgeInsets.all(10.0),
//                         child: Row(
//                           children: <Widget>[
//                             CircleAvatar(
//                               backgroundImage: NetworkImage(
//                                 data['photo'],
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20.0,
//                             ),
//                             Column(
//                               children: <Widget>[
//                                 Text(data['full_name']),
//                                 Text('@${data['display']}'),
//                               ],
//                             )
//                           ],
//                         ),
//                       );
//                     }),
//                 Mention(
//                   trigger: '#',
//                   disableMarkup: true,
//                   style: TextStyle(
//                     color: Colors.blue,
//                   ),
//                   data: [
//                     {'id': 'reactjs', 'display': 'reactjs'},
//                     {'id': 'javascript', 'display': 'javascript'},
//                   ],
//                   matchAll: true,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
