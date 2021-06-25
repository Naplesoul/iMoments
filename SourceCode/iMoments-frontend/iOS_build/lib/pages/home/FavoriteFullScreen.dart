import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:imoments/HttpMethod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:dio/dio.dart';
import 'package:imoments/userInfo.dart';

import '../../bottom_navigation.dart';
import '../../userInfo.dart';
import '../login.dart';

class FavoriteFullScreen extends StatefulWidget{
  final int index;
  FavoriteFullScreen({this.index});

  @override
  _FavoriteFullScreen createState() => _FavoriteFullScreen();
}
class _FavoriteFullScreen extends State<FavoriteFullScreen>{
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  Future _saveImage(index) async {
    if (await Permission.storage.request().isGranted) {
      var url = tempStorage_fav[index];
      var ran = Random().nextDouble();

      var response = await Dio().get(
          url,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: "favorPic$ran");
      if (result["isSuccess"]) {
        Fluttertoast.showToast(
          msg: "成功保存到${result["filePath"]}",
        );
      } else {
        Fluttertoast.showToast(
          msg: "failed",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Stack(children: [
          PhotoView(
            imageProvider: NetworkImage(tempStorage_fav[currentIndex]),
            initialScale: PhotoViewComputedScale.contained * 1,
            minScale: PhotoViewComputedScale.contained * 1,
            backgroundDecoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onLongPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (builder){
                    return Container(
                      color: Colors.transparent,
                      height: 120,
                      child: Column(
                        children: <Widget>[
                          TextButton(
                              onPressed: () async {
                                _saveImage(currentIndex);
                              },
                              child: Text('保存图片')
                          ),
                          TextButton(
                              onPressed: () async{
                                await _changeFav(currentIndex);
                                Navigator.pop(context);
                                Navigator.pop(context, true);
                              },
                              child: Text('取消收藏')
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
        ],)
    );
  }

  Future<bool> _changeFav(int index) async{
    var saveUrl = tempStorage_fav[index];

    if(tempStorage_fav.contains(saveUrl)) {
      tempStorage_fav.remove(saveUrl);
      return await _uploadFavorRemove(index);
    }
    return true;
  }

  Future<bool> _uploadFavorRemove(int index) async {
    var url = storage_url + 'removeFavor?token=$storage_token&url=${tempStorage_fav[index]}';
    return await dioPost(url);
  }
}