import 'package:emddi_bus/bus_stop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'const_value.dart';
import 'draw_bus_route.dart';
import 'map_to_show_route.dart';

class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search>{

  List<BusStop> listSearch = [];
  bool isVisible = true;
  bool isVisible1 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
          title: Text("Tra cứu"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Tuyến bus",),
              Tab(text: "Điểm bus",)
            ],
          )
        ),
        body: TabBarView(
          children: [
            //list bus
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
                //list bus
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  alignment: Alignment.centerLeft,
                  color: Colors.amber[100],
                  child: Text(
                    "Danh sách tuyến bus",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DrawRoute(routeId: "${LIST_ROUTE[index].routerId}")));
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Text("${LIST_ROUTE[index].routerId}", style: TextStyle(color: Colors.black),),
                          ),
                          title: Text("${LIST_ROUTE[index].startPoint} - ${LIST_ROUTE[index].endPoint}"),
                          subtitle: Text(LIST_ROUTE[index].city),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemCount: LIST_ROUTE.length),
                )
              ],
            ),
            //list bus stop
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
                      hintText: "Tìm kiếm",
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
                //list bus stop
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
            ),
          ],
        ),
      ),
    );
  }
}