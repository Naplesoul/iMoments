import 'package:flutter/material.dart';
import 'Settings.dart';
import 'FullScreen.dart';
import 'MyFavorite.dart';
import 'MyMomentsPage.dart';
import '../userInfo.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150, //上框高度
            decoration: BoxDecoration(
              border: Border.all(width: 1),
            ),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: _showModalBottomSheet,
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 20, top: 25),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(Global.image.path),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 60, right: 16),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: Text(
                          Global.userName,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        child: Text("      ID: DongD_0706"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          /*我的动态*/
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return MyMomentsPage();
              }));
            }, //点击后跳转
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    child: Icon(Icons.spa_outlined),
                  ),
                  Container(
                    child: Text("我的动态"),
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
            height: 1,
            thickness: 1,
          ),
          /*收藏*/
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return MyFavorite();
              }));
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
            height: 1,
            thickness: 1,
          ),
          /*设置*/
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return Settings();
              }));
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
            height: 1,
            thickness: 1,
          )
        ],
      ),
    );
  }

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      //imgPath = image;
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      //imgPath = image;
    });
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
                }));
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
