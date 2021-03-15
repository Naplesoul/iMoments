import 'package:flutter/material.dart';
import 'galleryShow.dart';
import 'dart:math';

class GalleryPage extends StatefulWidget {
  @override
  GalleryPageState createState() => new GalleryPageState();
}

class GalleryPageState extends State<GalleryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _imageCounter = -1;
  int number = 0;
  var ran = new Random();
  List<Image> _images = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              showSearch(context: context, delegate: SearchBar());
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
                //todo: 过滤器
            },
          ),
        ],
      ),
      body: GridView.builder(
          padding: EdgeInsets.all(4.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemBuilder: (context, index) {
            if(index ~/ 50 != _imageCounter) {
              number = ran.nextInt(1500);
              List<Image> _moreImages = List<Image>.generate(
                50, (i) => Image.network(
                'https://www.imoments.com.cn/resource/img/3/${number + 10 * i}.jpg',
                fit: BoxFit.cover,
              ),
              );
              _images.addAll(_moreImages);
              _imageCounter++;
            }

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return GalleryShowPage(index: number + 10 * (index % 50) ,);
                  },
                ));
              },
              child: _images[index],
            );
          }
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        },
        );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      //todo: add search results
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      //todo: search suggestions
      child: Center(
        child: Text('suggestions'),
      )
    );
  }
}