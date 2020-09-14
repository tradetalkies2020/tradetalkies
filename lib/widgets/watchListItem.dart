import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class WatchListItem extends StatefulWidget {
  final String name, code, rate;
  const WatchListItem({
    Key key,this.code,this.name,this.rate,
  }) : super(key: key);

  @override
  _WatchListItemState createState() => _WatchListItemState();
}

  var data = [0.0,1.0,1.5,2.0,0.0,0.0,-0.5,-1.0,-0.5,-0.0,-0.0];
class _WatchListItemState extends State<WatchListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.code,style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black,letterSpacing: 0.4)),
                              SizedBox(height: 6,),

            Text(widget.name,style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal,letterSpacing: 0.4))
            ],
          ),
          Container(
            height: 50,
            width: 120,
            // color: Colors.yellow,
            child: new Sparkline(
                // sharpCorners: true,
                data: data,
                lineWidth: 1.0,
                lineColor: Color(0xFF219653),
                ),
          ),
          Container(
                      // padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color(0xFF219653).withOpacity(0.1),
                      ),
                      // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      width: 75,
                      height: 35,
                      child: Center(
                        child: Text(
                          '₹${widget.rate}',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(fontWeight: FontWeight.normal,fontSize: 14,color: Color(0xFF219653)),
                        ),
                      ),
                    )
          ]
        ,),
      ),
    );
  }
}
