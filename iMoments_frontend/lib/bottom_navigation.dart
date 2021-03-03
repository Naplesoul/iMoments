import 'package:flutter/material.dart';
import 'pages/gallery.dart';
import 'pages/home.dart';
import 'pages/post.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => new _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  var _pages = <Widget>[
    GalleryPage(),
    PostPage(),
    HomePage(),
  ];
  final _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: _pageChange,
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 30,
            ),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.blue[300],
        selectedItemColor: Colors.blue[900],
      ),
    );
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void _pageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}