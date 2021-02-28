import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  List<Card> _buildGridCards(int count) {
    List<Card> cards = List.generate(
        count,
        (int index) => Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Image.asset('assets/projectLogo.jpg'),
              ),
            ],
          ),
        )
    );
    
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Gallery',
          style: TextStyle (
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30.0,
              color: Colors.black,
              semanticLabel: 'search',
            ),
            onPressed: () {

            },
          ),
          IconButton(
              icon: Icon(
                Icons.tune,
                color: Colors.black,
                size: 30,
                semanticLabel: 'filter',
              ),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
            crossAxisCount: 2,
          padding: EdgeInsets.all(10),
          childAspectRatio: 8 / 9 ,
          children: _buildGridCards(10),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}