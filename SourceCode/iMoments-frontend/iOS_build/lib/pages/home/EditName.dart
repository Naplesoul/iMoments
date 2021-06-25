import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:imoments/userInfo.dart';
import '../../bottom_navigation.dart';
import '../../userInfo.dart';
import '../../HttpMethod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

import '../login.dart';
var _url = 'https://http://1.15.86.128:8080/';

class EditName extends StatefulWidget{
  @override
  _EditName createState() => _EditName();
}
class _EditName extends State<EditName>{
  var _controller = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            IconButton(icon: Icon(Icons.save), onPressed: (){
              if (_formKey.currentState.validate()) changeUserName();
            }),
          ],
        ),
        body:
        Form(
          key: _formKey,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "请输入修改后的昵称",
              labelText: "昵称",
            ),
            controller: _controller,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-z,A-Z,0-9,_,-]")),
            ],
            validator: (value) {
              if (value.isEmpty)
                return '用户名不能为空';
              if (value.length > 12 || value.length < 3)
                return '用户名长度为3~12位';
              return null;
            },
          ),
        )
    );
  }

  /*更改用户昵称*/
  Future changeUserName() async {
    // /*先从本地获取数据*/

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(storage_url + "info?token=" + storage_token);
    /*获取用户输入内容*/
    var _changedName = _controller.text.toString();
    var str = '{"username":"' + _changedName + '","password":"' +
        storage_password + '"}';

    var res = await http.post(url, body: str);
    var json = jsonDecode(res.body);
    if (json['status'] == "wrong token") {
      Fluttertoast.showToast(msg: "已在其他设备登录");
      Future.delayed(Duration(seconds: 2), () {
        removeInf();
        /*一直pop到loginPage*/
        Navigator.pushAndRemoveUntil(context,
            new MaterialPageRoute(builder: (BuildContext c) {
              return new BottomNavigationWidget();
            }), (r) => r == null);
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return BottomNavigationWidget();
        })).then((value) {
          setState(() {

          });
        });
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return LoginPage();
        })).then((value) {
          setState(() {

          });
        });
      });
    }

    if (res.statusCode == 200) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('修改成功'),
            );
          }
      );
      /*实时更新名字*/
      setState(() {
        storage_userName = _changedName;
      });
      /*将改变后数据保存在本地*/
      save();
    }
    else {
      _controller.clear();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('用户名已存在'),
            );
          }
      );
    }
  }
}
