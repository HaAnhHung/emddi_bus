import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistorySearch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HistorySearchState();

}

class _HistorySearchState extends State<HistorySearch> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử tìm đường"),
      ),
      body: Center(
        child: Text("Bạn chưa có lịch sử tìm đường"),
      )
    );
  }
}