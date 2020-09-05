import 'package:fireauth/screens/home/post.dart';
import 'package:fireauth/screens/home/search_screen.dart';
import 'package:fireauth/screens/home/stock_info.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:fireauth/widgets/feed_post.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:fireauth/widgets/search_bar.dart';
import 'package:fireauth/widgets/trending_stock.dart';
import 'package:fireauth/widgets/watchListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:english_words/english_words.dart' as english_words;


class Feeds extends StatefulWidget { 
  Feeds({
    Key key,this.profileUrl,this.postText,this.postName,this.postImages,this.isPost,this.hasPhoto,this.postId
  }) : super(key: key);

  final String postName, postText, profileUrl,postId;
  List postImages;
  final bool isPost,hasPhoto;

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  _MySearchDelegate _delegate;
  final List<String> kEnglishWords;
  List<String> stocks = ['ABC', 'def', 'qwerty'];
  List<String> codes = ['ABC', 'DEF', 'QWERTY'];

  _FeedsState()
      : kEnglishWords = List.from(Set.from(english_words.all))
          ..sort(
            (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
          ),
        super();

  @override
  void initState() {
    super.initState();
    _delegate = _MySearchDelegate(kEnglishWords ,kEnglishWords);
  }

  List feed_type = ['Trending', 'Watchlist', 'Following', 'Suggestions'];
  List<bool> selected_feed = [true, false, false, false];

  List imageAssets = [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ];
  int Index=0;
  List <Widget> ac =  [
    Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,
              ),
              //   Divider(),

              Feed_post(
                name: 'sarthak',
                time: '4mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,

              ),

              //Divider(),
              Feed_post(
                name: 'AmanKumar',
                time: '6mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,

              ),

              //Divider(),
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,

              ),

              //Divider(),
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,
                
              ), 
    
  ];

 List <Widget> sc =  [
    Feed_post(
                name: 'Sahak',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,

              ),
              //   Divider(),

              Feed_post(
                name: 'syiyiyi',
                time: '4mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,

              ),

              //Divider(),
              Feed_post(
                name: 'AmanKumar',
                time: '6mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,

              ),

              //Divider(),
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,

              ),

              //Divider(),
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: [
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png'),
    AssetImage('assets/images/avatar.png')
  ],
                isPost: false,
                isLiked: false,likes: 10,comment: 10,repost: 10,

              ), 
    
  ]; 

 
  
  buildItem(BuildContext context, String value, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selected_feed.setAll(0, [false, false, false, false]);
          // print(selected_feed);
          selected_feed[index] = true;
          // print(selected_feed);
          Index=index;
        });
      },
      child: Container(
        margin: EdgeInsets.all(7),

        // padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: selected_feed[index]
              ? Color(0xFF3d96ff).withOpacity(0.1)
              : Color(0xFFa5a5a5).withOpacity(0.1),
          border: selected_feed[index]
              ? Border.all(color: Color(0xFF3D96FF), width: 1)
              : null,
        ),

        // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        width: index == 3 ? 110 : 90,

        // height: 42,
        child: Center(
          child: Text(
            value,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                letterSpacing: 0.4,
                color: selected_feed[index] ? Color(0xFF3D96FF) : Colors.black),
          ),
        ),
      ),
    );
  }

  bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              color: Colors.black,
            ));
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async{
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => searchScreen()));
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
                          'Search/Explore',
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
                height: 15,
              ),
              Container(
                // color: Colors.red,
                padding: EdgeInsets.only(right: 8.0),
                margin: EdgeInsets.only(left: 15),

                height: 55,
                child: ListView.builder(
                  itemCount: feed_type.length,
                  scrollDirection: Axis.horizontal,    
                  itemBuilder: (context, index) {
                    return buildItem(context, feed_type[index], index);
                  },
                ),
              ),
              SizedBox(height: 10),

              // Container(
              //   height: 450,
              //   child: ListView.builder(
              //       itemCount: feed_type.length,
              //       scrollDirection: Axis.vertical,
              //       itemBuilder: (context, index) {
              //         return Feed_post();
              //       },
              //     ),
              // )

              
              widget.isPost?Feed_post(postId: widget.postId,hasPhoto: widget.hasPhoto,name:widget.postName,text: widget.postText,time: '1min ago',imageAsset: widget.hasPhoto?widget.postImages:null,imageUrl: widget.profileUrl,isPost: true,isLiked: false,likes: 0,comment: 0,repost: 0,):SizedBox(height: 1,),
               //Divider(), 

              

              Column(
                children: Index==0?ac:(Index==1?sc:(Index==2?ac:sc)),
              ),
              
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
                isLiked: true,likes: 10,comment: 10,repost: 10,
              ),
              //   Divider(),

              Feed_post(
                name: 'sarthak',
                time: '4mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
                isLiked: true,likes: 10,comment: 10,repost: 10,
              ),

              //Divider(),
              Feed_post(
                name: 'AmanKumar',
                time: '6mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
                isLiked: true,likes: 10,comment: 10,repost: 10,
              ),

              //Divider(),
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
                isLiked: true,likes: 10,comment: 10,repost: 10,
              ),

              //Divider(),
              Feed_post(
                name: 'Manikanth',
                time: '2mins ago',
                text:
                    'Don’t worry, when this crashes, all the hypocrities who are shouting will buy and sell the stocks ',
                imageAsset: imageAssets,
                isPost: false,
                isLiked: true,likes: 10,comment: 10,repost: 10,
              ),
            ],
          ),
        ),  
        backgroundColor: Color(0xFFFFFFFF),
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: SvgPicture.asset("assets/new_icons/edit.svg"),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          onPressed: () {
            // _auth.signOut();
            // Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => post()));
          },
        ));
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
        _history = <String>['Microsoft', 'Apple', 'Tesla', 'Reliance'],
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
    return StockInfo(
      name: this.query,
      code: code,
      fromSearch: true,
    );
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

