import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';
import 'package:imoments/HttpMethod.dart';
import 'package:imoments/userInfo.dart';

import '../../bottom_navigation.dart';
import '../../userInfo.dart';
import '../login.dart';

class FullScreen extends StatefulWidget{
  @override
  _FullScreen createState() => _FullScreen();
}

class _FullScreen extends State<FullScreen>{
  Future _saveImage(String imgPath) async {
    if (await Permission.storage.request().isGranted) {
      var url = storage_url + "portrait?token=" + storage_token;
      var ran = Random().nextDouble();

      var response;
      try {
        //404
        response = await Dio().get(
            url,
            options: Options(responseType: ResponseType.bytes)
        );
      } on DioError catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (e.response != null) {
          if(e.response.data['status'] == 'wrong token') {
            Fluttertoast.showToast(msg: "已在其他设备登录");
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
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          print(e.message);
          Fluttertoast.showToast(msg: "sending message error!");
        }
      }

      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: "portrait$ran");
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
            imageProvider: imgPath == null ? NetworkImage(storage_url + "portrait?token=" + storage_token) : FileImage(File(imgPath)),
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
                      height: 60,
                      child: Column(
                        children: <Widget>[
                          TextButton(
                              onPressed: () {
                                _saveImage(imgPath);
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
        ],)


    );
  }
}
