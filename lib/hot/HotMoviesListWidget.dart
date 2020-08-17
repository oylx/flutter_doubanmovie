import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_doubanmovie/hot/HotMovieItemWidget.dart';
import 'package:flutter_doubanmovie/hot/HotMovieData.dart';
import 'package:http/http.dart' as http;

class HotMoviesListWidget extends StatefulWidget {

  String curCity;

  HotMoviesListWidget(this.curCity);
   
  @override
  HotMoviesListWidgetState createState() => HotMoviesListWidgetState();
}

class HotMoviesListWidgetState extends State<HotMoviesListWidget> with AutomaticKeepAliveClientMixin {

  List<HotMovieData> hotMovies = new List<HotMovieData>();
  @override
  bool get wantKeepAlive => true; //返回 true，表示不会被回收

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async{
    List<HotMovieData> serverDataList = new List();
    var response = await http.get(
        'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E6%B7%B1%E5%9C%B3&start=0&count=10');
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      for (dynamic data in responseJson['subjects']) {
          HotMovieData hotMovieData = HotMovieData.fromJson(data);
          serverDataList.add(hotMovieData);
      }
      setState(() {
        hotMovies = serverDataList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return HotMovieItemWidget(hotMovies[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(height: 1, color: Colors.black12);
            },
            itemCount: hotMovies.length));
  }
}
