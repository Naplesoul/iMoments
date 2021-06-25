import 'package:flutter/material.dart';
import 'dart:async';
import '../HttpMethod.dart';
import 'package:imoments/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget{
  SplashPage({Key key}):super(key:key);
  @override
  _SplashPage createState()=> new _SplashPage();

}

class _SplashPage extends State<SplashPage>{

  bool isStartHomePage = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          color: Colors.white,
          child: Image.asset("assets/teamlogo.png"),
        ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }

  //页面初始化状态的方法
  @override
  void initState() {
    super.initState();
    countDown();
  }

  void countDown() async{
    //registerWxApi(appId: "wxb3a622c6191e32ae");   //暂时不需要直接调用WX API
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("secretTheme")) {
      secretThemeFlag = prefs.getBool("secretTheme");
    }
    var duration = new Duration(seconds: 2);
    new Future.delayed(duration, goToPage);
  }

  void goToPage() async{
    if(!isStartHomePage){
      bool flag = await autoLogin();
      if(!flag) {
        Navigator.pushReplacementNamed(context, "/login");
      }
      else {
        Navigator.of(context).pop(this);
      }
      isStartHomePage=true;
    }
  }

  autoLogin() async{
    await get();
    if(storage_password != null && storage_password.isNotEmpty) {
      int statusCode = await userLogin();
      if(statusCode == 200) {
        getFavor();
        return true;
      }
    }
    return false;
  }

}
