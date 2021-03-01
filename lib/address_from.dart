import 'package:emddi_bus/const_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bus_stop.dart';

class AddressFrom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddressFrom();
}

class _AddressFrom extends State<AddressFrom> {
  List<String> listAddress = LIST_ADDRESS;

  List<BusStop> listSearch = [];
  bool isVisible = true;
  bool isVisible1 = false;

  search(String value){
    if (value == null) {
      isVisible = true;
      isVisible1 = false;
    }
    else if (value != null) {
      isVisible = false;
      isVisible1 = true;
      listSearch.clear();
      for (int i=0; i<LIST_BUS_STOP.length; i++){
        if (LIST_BUS_STOP[i].name.toLowerCase().trim().contains(value.toLowerCase().trim())){
          listSearch.add(LIST_BUS_STOP[i]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.amber,
          title: Text("Chọn điểm bắt đầu", style: TextStyle(color: Colors.black),),
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [Tab(text: "Địa điểm"), Tab(text: "Điểm dừng bus")],
          ),
        ),
        body: TabBarView(children: [
          //search location
          Column(
            children: [
              //search
              Container(
                margin: EdgeInsets.only(left: 8, top: 8, right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300], width: 0.5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Tìm địa điểm",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, top: 15),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25,
                      ),
                      suffixIcon: Icon(
                        Icons.cancel,
                        size: 20,
                        color: Colors.grey[400],
                      )),
                ),
              ),
              //recent address
              Container(
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                color: Colors.amber[100],
                child: Text(
                  "Các điểm đã đi",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              //list of recent address
              Expanded(
                child: ListView.separated(
                  itemCount: listAddress.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      mouseCursor: MouseCursor.defer,
                      onTap: () {
                        Navigator.pop(context, "${listAddress[index]}");
                      },
                      leading: Icon(
                        Icons.history,
                        color: Colors.grey[400],
                        size: 35,
                      ),
                      title: Text(
                        "${listAddress[index]}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text("2 phút trước"),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
          //search bus stop
          Column(
            children: [
              //search
              Container(
                margin: EdgeInsets.only(left: 8, top: 8, right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300], width: 0.5)),
                child: TextField(
                  onChanged: (String value){
                    setState(() {
                      search(value);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Tìm điểm dừng",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, top: 15),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25,
                    ),
                    suffixIcon: Icon(
                      Icons.cancel,
                      size: 20,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                color: Colors.amber[100],
                child: Text(
                  "Danh sách điểm bus",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              //list bus stop
              Visibility(
                visible: isVisible,
                child: Expanded(
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.amber,
                          ),
                          title: Text("${LIST_BUS_STOP[index].name} "),
                          subtitle: Text("Các tuyến xe đi qua: ${LIST_BUS_STOP[index].routeId}"),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemCount: LIST_BUS_STOP.length),
                ),
              ),
              Visibility(
                visible: isVisible1,
                child: Expanded(
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.amber,
                          ),
                          title: Text("${listSearch[index].name} "),
                          subtitle: Text("Các tuyến xe đi qua: ${listSearch[index].routeId}"),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemCount: listSearch.length),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
