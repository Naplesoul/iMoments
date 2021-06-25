
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imoments/pages/home/FavoriteFullScreen.dart';
import 'package:imoments/userInfo.dart';

const List<Color> _kColors = const <Color>[
  Colors.white70,
  Colors.blue,
  Colors.red,
  Colors.pink,
  Colors.indigo,
  Colors.purple,
  Colors.blueGrey,
];

List<StaggeredTile> _generateRandomTiles(int count) {
  Random rnd = Random();
  return List.generate(count,
          (i) => StaggeredTile.count(2, 2));
}

List<Color> _generateRandomColors(int count) {
  Random rnd = Random();
  return List.generate(count, (i) => _kColors[rnd.nextInt(_kColors.length)]);
}

class MyFavorite extends StatefulWidget{
  @override
  _MyFavorite createState() => _MyFavorite();
}

class _MyFavorite extends State<MyFavorite> {
  _MyFavorite()
      : _tiles = _generateRandomTiles(_kItemCount).toList(),
        _colors = _generateRandomColors(_kItemCount).toList();

  static const int _kItemCount = 1000;
  final List<StaggeredTile> _tiles;
  final List<Color> _colors;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('我的收藏'),
        ),
        body: new StaggeredGridView.countBuilder(
          primary: false,
          crossAxisCount: 4,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          staggeredTileBuilder: _getTile,
          itemBuilder: _getChild,
          itemCount: tempStorage_fav.length,
        ));
  }

  StaggeredTile _getTile(int index) => _tiles[index];

  Widget _getChild(BuildContext context, int index) {
    return new GestureDetector(
      child: new Container(
        key: new ObjectKey('$index'),
        color: _colors[0],
        child: Image(
          image: NetworkImage(tempStorage_fav[index]),
          fit: BoxFit.cover,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return FavoriteFullScreen(index: index);
          },
        )).then((value) {
          setState(() {

          });
        });
      },
    );
  }

// _refresh () {
//   print("I'm here");
//   setState(() {
//
//   });
// }
}