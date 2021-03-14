import 'package:flutter/material.dart';
import 'EditName.dart';
import 'EditPassword.dart';
import 'userInfo.dart';
import 'login.dart';
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditName()));
              setState(() {
                storage_userName = storage_userName;
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
              }));},
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
                    child: Text(storage_password),
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
          /*退出*/
          InkWell(
            onTap: () {
              /*一直pop到loginPage*/
              Navigator.pushAndRemoveUntil(context,
                  new MaterialPageRoute(builder: (BuildContext c) {
                    return new BottomNavigationWidget();
                  }), (r) => r == null);
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return BottomNavigationWidget();
              }));
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return LoginPage();
              }));
              },
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Color.fromRGBO(200, 200, 200, 50), width: 1),
              // ),
              child:
                Center(
                    child: Text("退出"),
                ),
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: Container(
              //         child: Text("头像"),
              //         margin: const EdgeInsets.only(left: 20,),
              //       ),
              //     ),
              //   ],
              // ),
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
