import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginState();

}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Center(child: Text("Chào mừng bạn đến với EMDDIBUS!")),
              Container(margin: EdgeInsets.only(top: 10),child: Text("Nhập số điện thoại di động để tiếp tục")),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Số điện thoại"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}