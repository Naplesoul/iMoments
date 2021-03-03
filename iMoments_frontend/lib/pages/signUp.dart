import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  '注册',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
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
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                  child: Text('取消'),
                ),
                RaisedButton(
                  color: Colors.blue,
                  elevation: 5.0 ,
                  child: Text('注册'),
                  onPressed: () async {
                    if(_signUpFormKey.currentState.validate()) {
                      print(1);
                      var url = 'https://www.imoments.com.cn:8080/register';
                      var res = await http.post(url,
                          body: '{"username":"$_username","password":"$_firstPassword"}');

                      var json = jsonDecode(res.body);
                      print(json);
                      print(res.statusCode);

                      if (res.statusCode == 200)
                        Navigator.pop(context);
                      else {
                        _usernameController.clear();
                        _passwordController.clear();

                        showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('用户名已存在'),
                            );
                          }
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}