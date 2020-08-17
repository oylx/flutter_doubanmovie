import "package:flutter/material.dart";
import 'package:flutter_doubanmovie/hot/HotMoviesListWidget.dart';

class HotWidget extends StatefulWidget {

  @override
  HotWidgetState createState() => HotWidgetState();
}

class HotWidgetState extends State<HotWidget> {
  String curCity = '深圳';//用变量来存储当前的城市
  static const IconData search = IconData(0xe8b6, fontFamily: 'MaterialIcons');

  void _jumpToCitysWidget() async {
    print('1:');
    print(curCity);
    var selectCity =
        await Navigator.pushNamed(context, '/Citys', arguments: curCity);
    if (selectCity == null) return;
    setState(() {
      curCity = selectCity;
      print('2:');
      print(curCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Text(
                  curCity,
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  _jumpToCitysWidget();
                },
              ),
              Icon(Icons.arrow_drop_down),
              Expanded(
                flex: 1,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: '\uE8b6 电影 / 电视剧 / 影人',
                    contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    filled: true,
                    fillColor: Colors.black12,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                    constraints: BoxConstraints.expand(height: 50),
                    child: TabBar(
                      tabs: <Widget>[Tab(text: '正在热映'), Tab(text: '即将上映')],
                      unselectedLabelColor: Colors.black12,
                      labelColor: Colors.black87,
                      indicatorColor: Colors.black87,
                    )),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: <Widget>[
                        HotMoviesListWidget(curCity),
                        Center(child: Text('即将上映')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
