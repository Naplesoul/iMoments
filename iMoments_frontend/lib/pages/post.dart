import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => new _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List _filePath = [];
  final picker = ImagePicker();

  Future getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _filePath.add(image.path);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void deleteImage(int index) {
    _filePath.removeAt(index);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.public,
          color: Colors.black,
        ),
        title: Text(
          '生成朋友圈',
          style: (
            TextStyle(
              color: Colors.black,
              fontSize: 20,
            )
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          GridView.builder(
            padding: EdgeInsets.all(5),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemCount: _filePath.length == 9? _filePath.length: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (
                crossAxisSpacing: 3.0,
                crossAxisCount: 3,
                mainAxisSpacing: 3,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int position) {
                if((_filePath.isEmpty && position == 0) || position == _filePath.length) {
                  return GestureDetector(
                    onTap: getImage,
                    child: Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.add,
                        size: 40,
                      ),
                    ),
                  );
                }
                else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ShowImage(filePath: _filePath, index: position,);
                        },
                      ));
                    },
                    onLongPress: () {
                      showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(

                              title: Text(
                                  '删除图片'
                              ),
                              children: <Widget>[
                                ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                        child: Text('是'),
                                        onPressed: () {
                                          deleteImage(position);
                                          Navigator.of(context).pop(1);
                                        }
                                        ),
                                    FlatButton(
                                        child: Text('否'),
                                        onPressed: () {
                                          Navigator.of(context).pop(1);
                                        },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                      );
                    },
                    child: _filePath.length > position ?
                      Image.file(File(_filePath[position]), fit: BoxFit.cover,):
                      Container(),
                  );
                }
              }
          ),
          RaisedButton(
            child: Text('测试数据接口'),
            onPressed: () async {
              var url = 'https://www.imoments.com.cn:8080/login';
              var res = await http.post(url, body: '{"username":"123","password":"123456"}');

              var json = jsonDecode(res.body);
              print(json);
              print(res.statusCode);
            },
          ),
        ],
      ),
    );
  }
}

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
              onLongPress: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder){
                      return Container(
                        color: Colors.transparent,
                        height: 60,
                        child: Column(
                          children: <Widget>[
                            FlatButton(
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