import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'HttpMethod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'userInfo.dart';

var _url = 'https://www.imoments.com.cn:8080/';

class EditPassword extends StatefulWidget{
  @override
  _EditPassword createState() => _EditPassword();
}
class _EditPassword extends State<EditPassword>{
  var _controller = new TextEditingController();
  var _client = new http.Client();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("修改密码"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: (){ changeUserPassword(); Navigator.pop(context);}),
        ],
      ),
      body: TextField(
        decoration: InputDecoration(
          hintText: "请输入修改后的密码",
          labelText: "密码",
        ),
        controller: _controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(20), //限制长度
        ],
      ),

    );
  }

  /*更改用户昵称*/
  void changeUserPassword() async {
    setState(() {
      storage_password = _controller.text.toString();
    });
    // /*先从本地获取数据*/
    // get();
    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    // var url = _url + 'info?token=' + prefs.getString("token");
    // var str = '{"username":"' + prefs.getString("userName").toString() + '","password":"' + prefs.getString("password").toString() + '"}';
    //
    // /*获取用户输入内容*/
    // var _changedPassword = _controller.text.toString();
    // str = '{"username":"' +  prefs.getString("userName").toString() + '","password":"' + _changedPassword + '"}';
    //
    // var res = await http.post(url, body: str);
    // var json = jsonDecode(res.body);
    // print(json);
    //
    // /*实时更新名字*/
    // setState(() {
    //   password = _changedPassword;
    // });
    // /*将改变后数据保存在本地*/
    // save();
  }

}
// /*更改用户密码*/
// void changeUserPassword() async {
//   /*先从本地获取数据*/
//   get();
//
//   var url = _url + 'info?token=' + _token;
//   var str = '{"username":"' + _userName + '","password":"' + _password + '"}';
//
//   /*获取用户输入内容*/
//   var _changedPassword = _controller.text.toString();
//   str = '{"username":"' + _userName + '","password":"' + _changedPassword + '"}';
//
//   var res = await http.post(url, body: str);
//
//   /*将改变后数据保存在本地*/
//   save();
// }
