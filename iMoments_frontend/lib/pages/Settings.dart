import 'package:flutter/material.dart';
import 'EditName.dart';

class Settings extends StatefulWidget{
  @override
  _Settings createState() => _Settings();
}
class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: [
          /*编辑昵称*/
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return EditName();
              }));},
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
                    child: Text("青铜葵花"),
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
          /*编辑头像*/
          InkWell(
            onTap: null,
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Color.fromRGBO(200, 200, 200, 50), width: 1),
              // ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text("头像"),
                      margin: const EdgeInsets.only(left: 20,),
                    ),
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
        ],
      ),
    );
  }
}
