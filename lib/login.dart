import 'package:emddi_bus/const_value.dart';
import 'package:emddi_bus/main.dart';
import 'package:emddi_bus/verify_phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _controllerPhone = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _login(String phone) {
    FirebaseAuth auth = FirebaseAuth.instance;
    PHONE = phone;

    _verificationCompleted(AuthCredential credential) async {
      print("completed");

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => VerifyPhoneNumber()));

      // await auth.signInWithCredential(credential);
      // if user existed => auto login
      AuthResult result = await auth.signInWithCredential(credential);
        FirebaseUser user = result.user;

        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: "EMDDI BUS",
                    ),
            ),
          );
        }
    }

    _verificationFailed(AuthException exception) {
      print("Failed");
      Fluttertoast.showToast(
        msg: "Lỗi",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    }

    _codeSent(String verId, [int forceResendingToken]) {
      print("codeSent");
      OTP = verId;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => VerifyPhoneNumber()));
    }

    auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(microseconds: 60),
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: null);
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
            child: Text(
              "Chào mừng bạn đến với EMDDIBUS!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 50, left: 15),
            child: Text(
              "Nhập số điện thoại di động để tiếp tục",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            margin: EdgeInsets.only(left: 15, right: 15, top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Colors.grey)),
            child: TextField(
              controller: _controllerPhone,
              decoration: InputDecoration(
                hintText: "Số điện thoại",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 15),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  String phone = _controllerPhone.text.trim();
                  _login(phone);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPhoneNumber()));
                });
              },
              child: Text("Tiếp tục"),
            ),
          ),
        ],
      ),
    );
  }
}
