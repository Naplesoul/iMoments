import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../custom_router.dart';
import '../../userInfo.dart';
import 'dart:io';
import '../../HttpMethod.dart';
import 'Settings.dart';
import 'FullScreen.dart';
import 'MyFavorite.dart';
import 'MyMomentsPage.dart';
import 'package:imoments/userInfo.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var profile = NetworkImage(storage_url + "portrait?token=" + storage_token);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.people,
        ),
        title: Text(
          '我的',
        ),
      ),

      body: Column(
        children: [
          Container(
            height: 150, //上框高度
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: _showModalBottomSheet,
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 20, top: 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        /*头像*/
                        image: imgPath == null ? profile : FileImage(File(imgPath)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 40, right: 16),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          storage_userName,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Divider(),
                      Center(
                          child: Text(
                            "ID:   iMoments_" + storage_id,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 3,
          ),
          /*我的动态*/
          InkWell(
            onTap: () {
              // Navigator.of(context).push(CustomRouteHorizontal(MyMomentsPage())).then((value) {
              //   setState(() {
              //
              //   });
              // });
              Fluttertoast.showToast(msg: "该页面尚未完成");
            }, //点击后跳转
            child: Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    child: Icon(Icons.spa_outlined),
                  ),
                  Container(
                    child: Text("上传历史"),
                  ),
                  Expanded(
                    child: Container(
                      child: Icon(Icons.keyboard_arrow_right),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            height: 1,
            thickness: 1,
          ),
          /*收藏*/
          InkWell(
            onTap: () {
              Navigator.of(context).push(CustomRouteHorizontal(MyFavorite())).then((value) {
                setState(() {

                });
              });
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    child: Icon(Icons.collections),
                  ),
                  Container(
                    child: Text("收藏"),
                  ),
                  Expanded(
                    child: Container(
                      child: Icon(Icons.keyboard_arrow_right),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            height: 1,
            thickness: 1,
          ),
          /*设置*/
          InkWell(
            onTap: () {
              Navigator.of(context).push(CustomRouteHorizontal(Settings())).then((value) {
                setState(() {

                });
              });
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.black54, width: 1),
              // ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    child: Icon(Icons.settings),
                  ),
                  Container(
                    child: Text("设置"),
                  ),
                  Expanded(
                    child: Container(
                      child: Icon(Icons.keyboard_arrow_right),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            height: 1,
            thickness: 1,
          )
        ],
      ),
    );
  }

  /*拍照*/
  Future _takePhoto() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      imgPath = image.path;
    });
    postUserProfile(imgPath, storage_token);
  }

  /*相册*/
  Future _openGallery() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.gallery); //.then((image) => cropImage(image));
    setState(() {
      imgPath = image.path;
    });
    postUserProfile(imgPath, storage_token);
  }

  /*底部菜单栏*/
  Future<String> _showModalBottomSheet() {
    return showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () {
                _openGallery();
              },
              leading: new Icon(Icons.photo_library),
              title: new Text("从相册中选择图片"),
            ),
            new ListTile(
              onTap: () {
                _takePhoto();
              },
              leading: new Icon(Icons.photo_camera),
              title: new Text("拍照"),
            ),
            new ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FullScreen();
                })).then((value) {
                  setState(() {

                  });
                });
              },
              leading: new Icon(Icons.panorama_fish_eye),
              title: new Text("查看大图"),
            ),
            /*空行*/
            new Container(
              height: 5,
              color: Colors.grey,
            ),
            new ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                }, //返回上一页
                title: Container(
                  child: new Text("取消"),
                  alignment: Alignment.center,
                )),
          ],
        );
      },
    );
  }
}
