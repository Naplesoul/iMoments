import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imoments/pages/home.dart';
// import 'package:flutter_productapp/home/moudel/upload_result.dart';
// import 'package:flutter_productapp/home/util/screen.dart';
// import 'package:flutter_productapp/base_ui/themes.dart';
import 'package:dio/dio.dart';
import 'package:screen/screen.dart';
import 'package:image_crop/image_crop.dart';

class CropImageRoute extends StatefulWidget {
  CropImageRoute(this.image);

  File image; //原始图片路径

  @override
  _CropImageRouteState createState() => new _CropImageRouteState();
}

class _CropImageRouteState extends State<CropImageRoute> {
  double baseLeft; //图片左上角的x坐标
  double baseTop; //图片左上角的y坐标
  double imageWidth; //图片宽度，缩放后会变化
  double imageScale = 1; //图片缩放比例
  Image imageView;
  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Crop.file(
                  widget.image,
                  key: cropKey,
                  aspectRatio: 1.0,
                  alwaysShowGrid: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _crop(widget.image);
                  Navigator.pop(context);
                },
                child: Text('ok'),
              ),
            ],
          ),
        ));
  }

  Future<void> _crop(File originalFile) async {
    final crop = cropKey.currentState;
    final area = crop.area;
    if (area == null) {
      //裁剪结果为空
      print('裁剪不成功');
    }
    await ImageCrop.requestPermissions().then((value) {
      if (value) {
        ImageCrop.cropImage(
          file: originalFile,
          area: crop.area,
        ).then((value) {
          Navigator.pop(context);
        }).catchError(() {
          print('裁剪不成功');
        });
      } else {
        //upload(originalFile);
      }
    });
  }

  ///上传头像
  // void upload(File file) {
  //   print(file.path);
  //   Dio dio = Dio();
  //   dio
  //       .post("http://your ip:port/",
  //       data: FormData.from({'file': file}))
  //       .then((response) {
  //     if (!mounted) {
  //       return;
  //     }
  //     //处理上传结果
  //     UploadIconResult bean = UploadIconResult(response.data);
  //     print('上传头像结果 $bean');
  //     if (bean.code == '1') {
  //       Navigator.pop(context, bean.data.url);//这里的url在上一页调用的result可以拿到
  //     } else {
  //       Navigator.pop(context, '');
  //     }
  //   });
  // }
}