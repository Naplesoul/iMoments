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
  var _pageController = new PageController(initialPage: 0);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return _pages.elementAt(_currentIndex);
        },
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
    _pageController.animateToPage(index,duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _pageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}