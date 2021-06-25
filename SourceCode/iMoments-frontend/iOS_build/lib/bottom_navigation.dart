import 'package:flutter/material.dart';
import 'custom_router.dart';
import 'pages/gallery/gallery.dart';
import 'pages/home/home.dart';
import 'pages/post/post.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => new _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  Icon floatingIcon = Icon(Icons.add);
  var titles = ["Gallery", "Home"];
  var oriIcon = [Icon(Icons.photo_camera_back, size: 30,), Icon(Icons.home_outlined, size: 30,)];
  var selectedIcon = [Icon(Icons.photo, size: 32,), Icon(Icons.home, size: 32,)];
  var _pages = <Widget>[
    GalleryPage(),
    HomePage(),
  ];
  final _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView(
        // physics: NeverScrollableScrollPhysics(),
        onPageChanged: _pageChange,
        controller: _pageController,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        child: floatingIcon,
        onPressed: () {
          Navigator.of(context).push(CustomRouteVerticalUp(PostPage()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            SizedBox(width: 30,),
            SizedBox(height: 60, width: 70, child: bottomAppBarItem(0)),
            SizedBox(height: 60, width: 70, child: bottomAppBarItem(1)),
          ],
        ),
        shape: CircularNotchedRectangle(),
      ),
    );
  }

  void _onItemTapped(int index) {
    // _pageController.jumpToPage(index);
    _pageController.animateTo(
        MediaQuery.of(context).size.width*index ,
        duration: Duration(milliseconds: 530),
        curve: Curves.ease);
  }

  void _pageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget bottomAppBarItem(int index) {
    Icon theIcon = oriIcon[index];
    if (_currentIndex == index) {
      theIcon = selectedIcon[index];
    }
    Widget item = Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: theIcon,
        onTap: () {
          _onItemTapped(index);
        },
      ),
    );
    return item;
  }
}