import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../userInfo.dart';

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
        title: Text("编辑昵称"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: changeUserName)
        ],
      ),
      body: TextField(
        decoration: InputDecoration(
          hintText: "请输入修改后的昵称",
          labelText: "昵称",
        ),
        controller: _controller,
      ),
    );
  }
  void changeUserName() async{
    Map<String, String> bodyParams = new Map();
    bodyParams["username"] = _controller.text;

    _client
        .post(Global.httpUpdateAddress, body: [Global.userName],)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print('error');
      }
    }).catchError((error) {
      print('error');
    });
  }
}
