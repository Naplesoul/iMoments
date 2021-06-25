import 'package:flutter/material.dart';
import 'package:imoments/HttpMethod.dart';
import 'package:imoments/pages/home/newTheme.dart';
import 'EditName.dart';
import 'EditPassword.dart';
import '../../userInfo.dart';
import '../login.dart';
import 'package:imoments/bottom_navigation.dart';

class Settings extends StatefulWidget{
  @override
  _Settings createState() => _Settings();
}
class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {
            Navigator.of(context).pop('刷新')
          },
        ),
        title: Text("设置"),
      ),
      body: Column(
        children: [
          /*编辑昵称*/
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditName())).then((value) {
                setState(() {

                });
              });
              },
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text("昵称"),
                      margin: const EdgeInsets.only(left: 20,),
                    ),
                  ),
                  Container(
                    child: Text(storage_userName),
                  ),
                  Expanded(
                    child: Container(
                      child: Icon(Icons.keyboard_arrow_right),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          /*修改密码*/
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return EditPassword();
              })).then((value) {
                setState(() {

                });
              });},
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text("密码"),
                      margin: const EdgeInsets.only(left: 20,),
                    ),
                  ),
                  Container(
                    child: Text("********"),
                  ),
                  Expanded(
                    child: Container(
                      child: Icon(Icons.keyboard_arrow_right),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {return SetThemePage();})).then((value) {
                setState(() {

                });
              });
            },
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10),
              child: Container(
                child : Center(
                  child: Text("主题"),
                ),
              )
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          /*退出*/
          InkWell(
            onTap: () {
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
              },
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10),
              child:
                Center(
                    child: Text("退出"),
                ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
