import 'package:flutter/material.dart';

class MyFavorite extends StatefulWidget{
  @override
  _MyFavorite createState() => _MyFavorite();
}
class _MyFavorite extends State<MyFavorite>{
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏"),
      ),
    );
  }
}
