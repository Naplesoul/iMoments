import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../custom_router.dart';
import '../userInfo.dart';
import 'signUp.dart';
import '../HttpMethod.dart';

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

  _isDark () {
    return Theme.of(context).primaryColor != Color(0xff212121);
  }

  @override
  Widget build(BuildContext context) {
    print(storage_userName);
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
                    child:  _isDark() ? Image.asset('assets/whiteBgBlackFont.jpg') : Image.asset('assets/blackBgWhiteFont.jpg'),
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 10.0),
                  Text('iMoments', style: GoogleFonts.lato(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
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
                        if (value.isEmpty)
                          return '用户名不能为空';
                        if (value.length > 12 || value.length < 3)
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
                      decoration: InputDecoration(
                        labelText: '密码',
                      ),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value.length < 5) {
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
                  elevation: MaterialStateProperty.all(5.0),
                ),
                child: Text(
                  '登录',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var url = Uri.parse(storage_url + "login");
                    var res = await http.post(url,
                        body: '{"username":"$username","password":"$password"}');
                    var json = jsonDecode(res.body);

                    if (res.statusCode == 200) {
                      Navigator.pop(context);
                      /**************保存到本地****************/
                      setState(() {
                        storage_userName = username;
                        storage_password = password;
                        storage_token = json["token"];
                      });
                      getUserId();
                      getFavor();
                      save();
                    }
                    else {
                      if (json["status"] == "forbidden") {
                        _usernameController.clear();
                        _passwordController.clear();
                        Fluttertoast.showToast(
                          msg: "账号已被封停",
                        );
                      }
                      if (json["status"] == "unauthorized") {
                        _passwordController.clear();
                        Fluttertoast.showToast(
                          msg: "密码错误",
                        );
                      }
                      if (json["status"] == "no such user") {
                        _usernameController.clear();
                        _passwordController.clear();
                        Fluttertoast.showToast(
                          msg: "该用户不存在",
                        );
                      }
                    }
                  }
                },
              ),

              // TextButton(
              //     onPressed: () {
              //       print(storage_userName);
              //       print(storage_password);
              //       print(storage_id);
              //     },
              //     child: Text('调试用', style: TextStyle(color: Colors.black))
              // ),
              SizedBox(height: 60,),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    child: Text('注册', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).push(CustomRouteVerticalDown(SignUpPage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}