import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final List response;

  ResultPage({this.response});
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int num;
  List<Card> textResult = [];

  @override
  void initState() {
    num = widget.response.length;
    for(var r in widget.response) {
      textResult.add(Card(child: Text(r),));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("生成结果"),
      ),
      body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: num,
              itemBuilder: (context, index) {
                return textResult[index];
              }
       )
    );
  }
}