import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryShowPage extends StatefulWidget {
  final int index;
  GalleryShowPage({this.index});

  @override
  _GalleryShowPageState createState() => new _GalleryShowPageState();
}

class _GalleryShowPageState extends State<GalleryShowPage> {
  double _deltaY = 0;
  int currentIndex = 0;
  int initialIndex;
  int title;

  @override
  void initState() {
    currentIndex = widget.index;
    initialIndex = widget.index;
    title = initialIndex + 1;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = initialIndex + (49 - index) * 10;
      title = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollDirection: Axis.horizontal,
              scrollPhysics: const BouncingScrollPhysics(),
              pageController: PageController(initialPage: initialIndex), //点进去哪页默认就显示哪一页
              onPageChanged: onPageChanged,
              reverse: true,
              itemCount: 50,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage('https://www.iMoments.com.cn/resource/img/1/${initialIndex + (49 - index) * 10}.jpg'),
                  initialScale: PhotoViewComputedScale.contained * 1,
                  minScale: PhotoViewComputedScale.contained * 1,
                );
              },
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(color: Colors.white, fontSize: 17.0, decoration: null),
              ),
            ),
            GestureDetector(
              onVerticalDragStart: (DragStartDetails details) {
                _deltaY = 0;
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                _deltaY += details.delta.dy;
              },
              onVerticalDragEnd: (DragEndDetails details){
                if(_deltaY > 100 || _deltaY < -100) {
                  Navigator.of(context).pop(this);
                }
              },
              onLongPress: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder){
                      return Container(
                        color: Colors.transparent,
                        height: 60,
                        child: Column(
                          children: <Widget>[
                            TextButton(
                                onPressed: () {
                                  //todo: 保存图片
                                },
                                child: Text('保存图片')
                            ),
                          ],
                        ),
                      );
                    }
                );
              },
              onTap: () {
                Navigator.of(context).pop(this);
              },
            ),

          ],
        ),
      ),
    );
  }
}
