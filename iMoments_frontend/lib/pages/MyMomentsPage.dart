import 'package:flutter/material.dart';

class MyMomentsPage extends StatefulWidget{
  @override
  _MyMomentsPage createState() => _MyMomentsPage();
}
class _MyMomentsPage extends State<MyMomentsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("我的动态"),
        actions: [
          Icon(Icons.search),
        ],
      ),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
