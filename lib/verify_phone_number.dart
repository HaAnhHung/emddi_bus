import 'package:emddi_bus/const_value.dart';
import 'package:emddi_bus/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyPhoneNumber extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  var _controllerCode = new TextEditingController();

  _verifyCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: OTP,
      smsCode: _controllerCode.text.trim(),
    );

    AuthResult result = await auth.signInWithCredential(credential);
      FirebaseUser user = result.user;

      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: "EMDDI BUS",
                  )),
        );
        Fluttertoast.showToast(
            msg: "Đăng nhập thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "Nhập mã đăng nhập vừa được gửi về máy của bạn",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.only(left: 15, top: 10, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
              color: Colors.white,
            ),
            child: TextField(
              controller: _controllerCode,
              decoration: InputDecoration(
                  hintText: "Mã đăng nhập", border: InputBorder.none),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            alignment: Alignment.centerRight,
            child: FlatButton(
              child: Text("Đăng nhập"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _verifyCode();
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
