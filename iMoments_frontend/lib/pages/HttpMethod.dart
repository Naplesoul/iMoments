import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Global extends StatefulWidget {
  @override
  _Global createState() => _Global();

  static var httpGetInfoAddress = "http://1.15.86.128:8080/info";
  static var httpUpdateAddress = "http://1.15.86.128:8080/update";
  static File image = new File("images/bigHead.png");

  static var token = 'OQHQNQBIMALPIPYSTLNJYZXZBDZTSGFBUGWADRPOLHDANVVWTJAWJMDDCWJWZQPW';
  static var userName = "葵花";
  static var password = "Instance of 'Future<String>'";
  static var url = 'https://www.imoments.com.cn:8080/';
}
class _Global extends State<Global> {

  @override
  Widget build(BuildContext context) { return null;}
}


/*登录*/
void userLogin() async {
  /*获取本地数据*/
  get();

  var url = 'https://www.imoments.com.cn:8080/login';
  var str = '{"username":"' + Global.userName + '","password":"' + Global.password + '"}';

  var res = await http.post(url, body: str);

  var json = jsonDecode(res.body).toString();

  /*重置token值*/
    Global.token = json.substring(0, json.length - 1).split(" ").elementAt(4);

  /*保存数据*/
    save();
}
/*获取用户密码*/
Future<String> getUserPassword() async {
  var url = Global.url + 'info?token=' + Global.token;
  var res = await http.get(url);

  var json = jsonDecode(res.body);

  String userPassword = json.toString().split(" ").elementAt(1);

  return userPassword;
}
/*获取用户昵称*/
Future<String> getUserName() async {
  var url = Global.url + 'info?token=' + Global.token;
  var res = await http.get(url);

  var json = jsonDecode(res.body);

  String userName = json.toString().split(" ").elementAt(3);

  return userName;
}
/*获取用户头像*/
Future<File> getUserProfile() async {
  var url = Global.url + 'portrait?token=' + Global.token;
  var res = await http.get(url);

  //var json = jsonDecode(res.body);
  //print(json);
  return null;
}

/*更改用户*/
/*保存数据*/
void save() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("userName", Global.userName); //getUserName().toString());
  prefs.setString("password", Global.password); //getUserPassword().toString());
  prefs.setString("token", Global.token);
}
/*读取数据*/
void get() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Global.userName = prefs.getString("userName").toString();
  Global.password = prefs.getString("password").toString();
  Global.token = prefs.getString("token").toString();
}
