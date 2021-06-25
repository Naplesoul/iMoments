import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '../userInfo.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => new SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _signUpFormKey= GlobalKey<FormState> ();
  String _username;
  String _firstPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop(this);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 70.0),
            Column(
              children: [
                SizedBox(height: 16.0),
                Text(
                  'iMoments',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(height: 100.0),
            Form(
              key: _signUpFormKey,
              child: Column(
                children: [
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z,A-Z,0-9,_,-]")),
                    ],
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: '用户名',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    validator: (value) {
                      if(value.isEmpty)
                        return '用户名不能为空';
                      if(value.length > 12 || value.length < 3)
                        return '用户名长度为3~12位';

                      _username = value;
                      return null;
                    },
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z, A-Z, 0-9, _, -, ?, !, :, ', ;, ., @, #, %, ^, &, *, (, ), +, =, {, }, |]")),
                    ],
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: '密码',
                    ),
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    validator: (value) {
                      if(value.length < 5) {
                        return '密码长度必须大于5';
                      }

                      _firstPassword = value;
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ButtonStyle(
                //backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
                elevation: MaterialStateProperty.all(5.0),
              ),
              child: Text(
                '注册',
                style: TextStyle(
                  //color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () async {
                if(_signUpFormKey.currentState.validate()) {
                  var url = Uri.parse(storage_url+"register");
                  var res = await http.post(url,
                      body: '{"username":"$_username","password":"$_firstPassword"}');

                  var json = jsonDecode(res.body);
                  print(json);
                  print(res.statusCode);

                  if (res.statusCode == 200) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "注册成功");
                  }
                  else {
                    _usernameController.clear();
                    _passwordController.clear();

                    Fluttertoast.showToast(
                      msg: "该用户名已存在",
                    );
                  }
                }
              },
            ),
          ],
        ),

      ),
    );
  }
}