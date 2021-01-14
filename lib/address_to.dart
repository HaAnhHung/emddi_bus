import 'package:emddi_bus/const_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressTo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddressTo();

}

class _AddressTo extends State<AddressTo>{

  List<String> listAddress = LIST_ADDRESS;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.amber,
          title: Text("Chọn điểm kết thúc", style: TextStyle(color: Colors.black),),
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [Tab(text: "Địa điểm"), Tab(text: "Điểm dừng bus")],
          ),
        ),
        body: TabBarView(children: [
          //search location
          Column(
            children: [
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
              //recent location
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, "${listAddress[index]}");
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.history,
                              color: Colors.grey[400],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "${listAddress[index]}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                ),
              ),
            ],
          ),
          //search bus stop
          Column (
            children: [
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
            ],
          )
        ]),
      ),
    );
  }

}