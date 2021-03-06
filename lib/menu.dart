import 'dart:io';

import 'package:emddi_bus/const_value.dart';
import 'package:emddi_bus/info_user.dart';
import 'package:emddi_bus/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MenuState();
}
class _MenuState extends State<Menu> {
  final List<String> listOption = LIST_OPTION;
  final List<IconData> listIconOption = LIST_ICON_OPTION;

  // File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //link to phone
  _launchCaller() async {
    const url = "tel:1800 8888";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _getWidgetImage(){
    if(FILE_AVATAR != null)
      return CircleAvatar(
        radius: 40,
        backgroundImage: FileImage(FILE_AVATAR),
      );
    else return CircleAvatar(
      radius: 40,
      backgroundImage: AssetImage(PATH_AVATAR),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Container(
        color: Colors.black54,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: [
                  DrawerHeader(
                    margin: EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         // user
                         Row(
                           children: [
                             GestureDetector(
                               onTap: ()async{
                                 final result = await Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) => InfoUser()));
                                 setState(() {
                                   FILE_AVATAR = result;
                                 });
                               },
                               child: _getWidgetImage(),
                             ),
                             Container(
                                 margin: EdgeInsets.only(left: 15),
                                 child: Text(PHONE),
                             ),
                           ],
                         ),
                         //language
                         Container(
                           margin: EdgeInsets.only(top: 15),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               //vietnamese
                               FlatButton(
                                 padding: EdgeInsets.only(left: 0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
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
                       ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      listIconOption[0],
                      color: Colors.white,
                    ),
                    title: Text(
                      "${listOption[0]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      listIconOption[1],
                      color: Colors.white,
                    ),
                    title: Text(
                      "${listOption[1]}",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      listIconOption[2],
                      color: Colors.white,
                    ),
                    title: Text(
                      "${listOption[2]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      listIconOption[3],
                      color: Colors.white,
                    ),
                    title: Text(
                      "${listOption[3]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      listIconOption[4],
                      color: Colors.white,
                    ),
                    title: Text(
                      "${listOption[4]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      listIconOption[5],
                      color: Colors.white,
                    ),
                    title: Text(
                      "${listOption[5]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      listIconOption[6],
                      color: Colors.white,
                    ),
                    title: Text(
                      "${listOption[6]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      listIconOption[7],
                      color: Colors.white,
                    ),
                    title: Text(
                      "${listOption[7]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            //hotline
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: OutlineButton(
                onPressed: _launchCaller,
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_phone,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        "Hotline: 1800 8888",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
