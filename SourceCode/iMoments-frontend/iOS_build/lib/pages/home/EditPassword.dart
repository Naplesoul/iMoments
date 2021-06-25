import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../../bottom_navigation.dart';
import '../../userInfo.dart';
import '../../userInfo.dart';
import '../../HttpMethod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imoments/userInfo.dart';

import '../login.dart';

var _url = 'https://www.imoments.com.cn:8080/';

class EditPassword extends StatefulWidget{
  @override
  _EditPassword createState() => _EditPassword();
}
class _EditPassword extends State<EditPassword> {
  var _controller = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("修改密码"),
          actions: [
            IconButton(icon: Icon(Icons.save), onPressed: () {
              if (_formKey.currentState.validate()) changeUserPassword();
            }),
          ],
        ),
        body:
        Form(
          key: _formKey,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "请输入修改后的密码",
              labelText: "密码",
            ),
            controller: _controller,
            inputFormatters: [
              LengthLimitingTextInputFormatter(11), //限制长度
              FilteringTextInputFormatter.allow(RegExp("[a-z, A-Z, 0-9, _, -, ?, !, :, ', ;, ., @, #, %, ^, &, *, (, ), +, =, {, }, |]")),
            ],
            validator: (value) {
              if(value.length < 5) {
                return '密码长度必须大于5';
              }
              return null;
            },
          ),
        )
    );
  }

  Future changeUserPassword() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(storage_url + "info?token=" + storage_token);
    /*获取用户输入内容*/
    var _changedPassword = _controller.text.toString();
    var str = '{"username":"' + storage_userName + '","password":"' + _changedPassword + '"}';

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
        storage_password = _changedPassword;
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
              content: Text('修改失败'),
            );
          }
      );
    }
  }
}



