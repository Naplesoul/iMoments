import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imoments/HttpMethod.dart';
import 'package:imoments/userInfo.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bottom_navigation.dart';
import '../login.dart';

class GalleryShowPage extends StatefulWidget {
  final int index;
  final total;
  final imageNumbers;
  GalleryShowPage({this.index, this.total,this.imageNumbers});

  @override
  _GalleryShowPageState createState() => new _GalleryShowPageState();
}

class _GalleryShowPageState extends State<GalleryShowPage> {
  double _deltaY = 0;
  List _imageNumbers;
  int currentIndex = 0;
  int initialIndex;
  int total;
  int title;

  @override
  void initState() {
    total = widget.total;
    _imageNumbers = widget.imageNumbers;
    currentIndex = widget.index;
    initialIndex = 0;
    title = initialIndex;
    super.initState();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      title = currentIndex;
    });
  }
  
  Icon _getIcon(int index) {
    var url = gallery_url + 'resource/img/1/${_imageNumbers[index]}.jpg';
    if(tempStorage_fav.contains(url)) {
      return Icon(Icons.favorite, size: 30,);
    }
    else {
      return Icon(Icons.favorite_border, size: 30,);
    }
  }
  
  Future<bool> _uploadFavorRemove(int index) async {
    var url = storage_url + 'removeFavor?token=$storage_token&url=${gallery_url + 'resource/img/1/${_imageNumbers[index]}.jpg'}';
    return await dioPost(url);
  }
  
  Future<bool> _uploadFavorAdd(int index) async {
    var url = storage_url + 'favor?token=$storage_token&url=${gallery_url + 'resource/img/1/${_imageNumbers[index]}.jpg'}';
    return await dioPost(url);
  }

  Future<bool> _changeFav(int index) async {
    var saveUrl = gallery_url + 'resource/img/1/${_imageNumbers[index]}.jpg';
    if(tempStorage_fav.contains(saveUrl)) {
      tempStorage_fav.remove(saveUrl);
      this.setState(() { });
      return await _uploadFavorRemove(index);
    }
    else {
      tempStorage_fav.add(saveUrl);
      this.setState(() {  });
      return await _uploadFavorAdd(index);
    }
  }

  Future _saveImage(index) async {
    if (await Permission.storage.request().isGranted) {
      var url = gallery_url + 'resource/img/1/${_imageNumbers[index]}.jpg';

      var response = await Dio().get(
          url,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: "galleryPic$index");
      if (result["isSuccess"]) {
        Fluttertoast.showToast(
            msg: "成功保存到${result["filePath"]}",
        );
      }
    }
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
              pageController: PageController(initialPage: currentIndex), //点进去哪页默认就显示哪一页
              onPageChanged: _onPageChanged,
              itemCount: total,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(gallery_url + 'resource/img/1/${_imageNumbers[index]}.jpg'),
                  initialScale: PhotoViewComputedScale.contained * 1,
                  minScale: PhotoViewComputedScale.contained * 1,
                );
              },
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
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
                                  _saveImage(currentIndex);
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
            Container(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: _getIcon(currentIndex),
                      onTap: () async {
                        if(!await _changeFav(currentIndex)) {
                          await Future.delayed(Duration(seconds: 2), () {
                            removeInf();
                            /*一直pop到loginPage*/
                            Navigator.pushAndRemoveUntil(context,
                                new MaterialPageRoute(builder: (BuildContext c) {
                                  return new BottomNavigationWidget();
                                }), (r) => r == null);
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return BottomNavigationWidget();
                            })).then((value) {
                              setState(() {

                              });
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return LoginPage();
                            })).then((value) {
                              setState(() {

                              });
                            });
                          });
                        }
                      },
                    ),
                    Text(
                      "                      Image ${currentIndex}",
                      style: const TextStyle(color: Colors.white, fontSize: 17.0, decoration: null,),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
