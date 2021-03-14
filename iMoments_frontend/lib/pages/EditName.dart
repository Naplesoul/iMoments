import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'userInfo.dart';
import 'HttpMethod.dart';
import 'package:shared_preferences/shared_preferences.dart';

var _url = 'https://www.imoments.com.cn:8080/';

class EditName extends StatefulWidget{
  @override
  _EditName createState() => _EditName();
}
class _EditName extends State<EditName>{
  var _controller = new TextEditingController();
  var _client = new http.Client();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {
            Navigator.of(context).pop('刷新')
          },
        ),
        title: Text("编辑昵称"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: (){ changeUserName(); Navigator.pop(context); }),
        ],
      ),
      body: TextField(
        decoration: InputDecoration(
          hintText: "请输入修改后的昵称",
          labelText: "昵称",
        ),
        controller: _controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(20), //限制长度
        ],
      ),

    );
  }

  /*更改用户昵称*/
  changeUserName() {
    setState(() {
      storage_userName = _controller.text.toString();
    });
    // /*先从本地获取数据*/
     get();
    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    // var url = _url + 'info?token=' + prefs.getString("token");
    // var str = '{"username":"' + prefs.getString("userName").toString() + '","password":"' + prefs.getString("password").toString() + '"}';
    //
    // /*获取用户输入内容*/
    // var _changedName = _controller.text.toString();
    // str = '{"username":"' + _changedName + '","password":"' + prefs.getString("password").toString() + '"}';
    //
    // var res = await http.post(url, body: str);
    // var json = jsonDecode(res.body);
    // print(json);
    //
    // /*实时更新名字*/
    // setState(() {
    //   Global.userName = _changedName;
    // });
    // /*将改变后数据保存在本地*/
    // save();
  }

}
