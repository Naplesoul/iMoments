import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreen extends StatefulWidget{
  @override
  _FullScreen createState() => _FullScreen();
}
class _FullScreen extends State<FullScreen>{
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
          imageProvider: AssetImage(""),
        )
    );
  }
}
