import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imoments/pages/userInfo.dart';
import 'signUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 70.0),
              Column(
                children: [
                  Container(
                    child: Image.asset('assets/projectLogo.jpg'),
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 16.0),
                  Text('iMoments', style: TextStyle(fontSize: 20),),
                ],
              ),
              SizedBox(height: 60.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp("[ \\ ]")),
                      ],
                      controller: _usernameController..text = storage_userName,
                      decoration: InputDecoration(
                        labelText: '用户名',
                      ),
                      validator: (value) {
                        if(value.isEmpty)
                          return '用户名不能为空';
                        if(value.length > 12 || value.length < 3)
                          return '用户名长度为3~12位';

                        username = value;
                        return null;
                      },
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp("[ \\ ]")),
                      ],
                      controller: _passwordController..text = storage_password,
                      decoration: InputDecoration(
                        labelText: '密码',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if(value.length < 5) {
                          return '密码长度必须大于5';
                        }
                        password = value;
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
                  elevation: MaterialStateProperty.all(5.0),
                ),
                child: Text(
                  '登录',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    var url = 'https://www.imoments.com.cn:8080/login';
                    var res = await http.post(url,
                        body: '{"username":"$username","password":"$password"}');

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
                              content: Text('用户名或密码错误'),
                            );
                          }
                      );
                    }
                  }
                },
              ),

                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('调试用')
                  ),
              SizedBox(height: 60,),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    child: Text('注册'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => SignUpPage(),
                      )
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      //todo: 微信登陆功能
                    },
                    child: Icon(
                      Icons.add_circle,
                      size: 30,
                    ),
                  ),
                ],
              ),
              // RaisedButton(
              //   child: Text('测试数据接口'),
              //   onPressed: () async {
              //     var url = 'http://1.15.86.128:8080/login';
              //     var res = await http.post(url, body: '{"username":"123","password":"123456"}');
              //
              //     var json = jsonDecode(res.body);
              //     print(json);
              //     print(res.statusCode);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}