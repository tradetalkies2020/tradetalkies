import 'package:fireauth/screens/home/stock_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class TrendingStock extends StatefulWidget {
  final String name, code, percent;
  const TrendingStock({Key key, this.code, this.name, this.percent})
      : super(key: key);

  @override
  _TrendingStockState createState() => _TrendingStockState();
}

class _TrendingStockState extends State<TrendingStock> {
  var data = [0.0,1.0,1.5,2.0,0.0,0.0,-0.5,-1.0,-0.5,-0.0,-0.0];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StockInfo(
                      name: widget.name,
                      code: widget.code,
                      fromSearch: false,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0.5, 0.5))
            ]),
        width: 140,
        // height: 140,
        margin: EdgeInsets.all(7),
        padding: const EdgeInsets.only(top: 10.0, left: 10),
        // color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.name,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontWeight: FontWeight.normal, color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(right: 7,top: 7,bottom: 5),
              height: 47,
              // color: Colors.yellow,
              child: new Sparkline(
                // sharpCorners: true,
                data: data,
                lineWidth: 1.0,
                lineColor: Color(0xFF219653),
                ),
            ),
            Text(
              widget.code,
              style: Theme.of(context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF219653),
                  letterSpacing: 0.4),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              widget.percent,
              style: Theme.of(context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF219653),
                  letterSpacing: 0.4),
            )
          ],
        ),
      ),
    );
  }
}