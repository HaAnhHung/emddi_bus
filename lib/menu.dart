import 'package:emddi_bus/const_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  List<String> listOption = LIST_OPTION;
  List<IconData> listIconOption = LIST_ICON_OPTION;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //vietnamese
                    FlatButton(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage('images/vietnam.png'),
                              width: 40,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "Tiếng Việt",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //english
                    FlatButton(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'images/UK.png',
                              ),
                              width: 40,
                              height: 30,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                "Tiếng Anh",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(
                  listIconOption[0],
                  color: Colors.black,
                ),
                title: Text(
                  "${listOption[0]}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: Icon(
                  listIconOption[1],
                  color: Colors.black,
                ),
                title: Text(
                  "${listOption[1]}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: Icon(
                  listIconOption[2],
                  color: Colors.black,
                ),
                title: Text(
                  "${listOption[2]}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: Icon(
                  listIconOption[3],
                  color: Colors.black,
                ),
                title: Text(
                  "${listOption[3]}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: Icon(
                  listIconOption[4],
                  color: Colors.black,
                ),
                title: Text(
                  "${listOption[4]}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: Icon(
                  listIconOption[5],
                  color: Colors.black,
                ),
                title: Text(
                  "${listOption[5]}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: Icon(
                  listIconOption[6],
                  color: Colors.black,
                ),
                title: Text(
                  "${listOption[6]}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: Icon(
                  listIconOption[7],
                  color: Colors.black,
                ),
                title: Text(
                  "${listOption[7]}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]),
          ),
          //hotline
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(30)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.local_phone,
                  color: Colors.black,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Text(
                    "Hotline: 1900 8888",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
