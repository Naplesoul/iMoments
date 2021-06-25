import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ShowImage extends StatefulWidget {
  final List filePath;
  final int index;
  ShowImage({this.filePath, this.index});
  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  List _filePath;
  int currentIndex = 0;
  int initialIndex;

  @override
  void initState() {
    _filePath = widget.filePath;
    initialIndex = widget.index;
    super.initState();
  }

  void _onPageChanged(int index) {
    currentIndex = index;
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
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollDirection: Axis.horizontal,
              scrollPhysics: const BouncingScrollPhysics(),
              pageController: PageController(initialPage: initialIndex),
              reverse: false,
              onPageChanged: _onPageChanged,
              itemCount: _filePath.length,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(File(_filePath[index])),
                  initialScale: PhotoViewComputedScale.contained * 1,
                  minScale: PhotoViewComputedScale.contained * 1,
                );
              },
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            GestureDetector(
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