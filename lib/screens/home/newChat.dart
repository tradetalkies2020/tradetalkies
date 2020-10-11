import 'package:fireauth/screens/home/Edit_watchlist.dart';
import 'package:fireauth/screens/home/chatScreen.dart';
import 'package:fireauth/screens/home/post.dart';
import 'package:fireauth/screens/home/search.dart';
import 'package:fireauth/screens/home/search_screen.dart';
import 'package:fireauth/screens/home/stock_info.dart';
import 'package:fireauth/screens/home/stocks_data.dart';
import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:fireauth/widgets/search_bar.dart';
import 'package:fireauth/widgets/trending_stock.dart';
import 'package:fireauth/widgets/watchListItem.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as english_words;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class NewChat extends StatefulWidget {
  NewChat({
    Key key,
  }) : super(key: key);

  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  _MySearchDelegate _delegate;
  final List<String> kEnglishWords;
  List<String> stocks = ['ABC', 'def', 'qwerty'];
  List<String> codes = ['ABC', 'DEF', 'QWERTY'];

  _NewChatState()
      : kEnglishWords = List.from(Set.from(english_words.all))
          ..sort(
            (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
          ),
        super();

  @override
  void initState() {
    super.initState();
    _delegate = _MySearchDelegate(kEnglishWords, kEnglishWords);
  }

  buildItem(BuildContext context) {
    return TrendingStock(
      name: 'Microsoft',
      code: 'MSFT',
      percent: '+0.39%',
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Start chat',
          style: TextStyle(
              color: Colors.black,
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
      //                         builder: (context) => NewChat(
      //                               firstVisit: true,forEdit: true,
      //                             )));
      //               },
      //               child: Text('Edit info',
      //                   style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
      //             ),
      //           )
      //         ],
      // ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.c,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () async {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => AppBarSearchExample()));
                final String selected = await showSearches<String>(
                  context: context,
                  delegate: _delegate,
                );
                if (selected != null) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You have selected the word: $selected'),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color(0xFFF0F0F0),
                ),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: _large
                    ? _width - 45
                    : (_medium ? _width - 35 : _width - 25),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 35,
                      ),
                      SizedBox(
                        width: 6,
                      ),

                      Text(
                        'Search username or name',
                        style: TextStyle(
                            // height: 1.3,
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing: 0.2,
                            color: Color(0xff000000).withOpacity(0.4)),
                      )
                      // TextFormField(

                      //   decoration: InputDecoration(
                      //     border: InputBorder.none,
                      //     hintText: 'Search/Explore',
                      // hintStyle: TextStyle(
                      //     // height: 1.3,
                      //     fontFamily: 'Inter',
                      //     fontSize: 14,
                      //     color: Color(0xff000000).withOpacity(0.6)))
                      // )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ChatTile(name: 'Jerome Bell',path: 'assets/images/avatar.png',message: '@jermone',time: '11.11',count: '1',),
            ChatTile(name: 'Jerome Bell',path: 'assets/images/avatar.png',message: '@jermone',time: '11.11',count: '1',),
            ChatTile(name: 'Jerome Bell',path: 'assets/images/avatar.png',message: '@jermone',time: '11.11',count: '1',),
            ChatTile(name: 'Jerome Bell',path: 'assets/images/avatar.png',message: '@jermone',time: '11.11',count: '1',),
            
            
            // SizedBox(
            //   height: 30,
            // ),
          ],
        ),
      ),
            backgroundColor: Color(0xFFFFFFFF),

      
    );
  }
}

class ChatTile extends StatefulWidget {
  const ChatTile({
    Key key,this.name,this.time,this.count,this.message,this.path
  }) : super(key: key);

  final String path, name, message, count, time;

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        ListTile(
          onTap: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatScreen(name:widget.name,path:widget.path,fromSearch: false,)));
          },
          dense: true,
          contentPadding: EdgeInsets.only(left: 18, right: 18),
          leading: CircleAvatar(
            radius: 23,
            backgroundColor: Theme.of(context).accentColor,
            child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(widget.path)),
          ),
          title: Text(
            widget.name,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Color(0xFF000000)),
          ),
          //   title: Text('Jerome Bell',
          //   // style: TextStyle(fontFamily: 'Poppins',fontSize: 16)
          // ),
          subtitle: Text(
            widget.message,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Inter',
                color: Color(0xFF828282)),
          ),
          
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(left: 80),
          height: 1.5,
          color: Color(0xFFE8E8E8),
        ),
      ],
    );
  }
}

// Defines the content of the search page in `showSearch()`.
// SearchDelegate has a member `query` which is the query string.
class _MySearchDelegate extends SearchDelegates<String> {
  final List<String> _words;
  final List<String> _history;
  final List<String> _codes;

  _MySearchDelegate(List<String> words, List<String> codes)
      : _words = words,
        _codes = codes,
                _history = <String>['microsoft', 'apple', 'tesla', 'reliance'],

        super();

  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        color: Colors.black,
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
        this.close(context, null);
      },
    );
  }

  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    String code;
    for (int i = 0; i < _words.length; i++) {
      if (_words[i] == this.query) {
        code = _codes[i];
      }
    }
    return ChatScreen(name:this.query,path:'assets/images/avatar.png',fromSearch:true);
    
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _SuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic, color: Colors.white),
              onPressed: () {
                // this.query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

// Suggestions list widget displayed in the search page.
class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
