import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imoments/pages/result.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../colors.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => new _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List _filePath = [];
  bool _ifFilled = false;
  String words;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Future printResult() async {
    ProgressDialog.showProgress(context, child: SpinKitRing(
      color: Colors.blue,
      size: 80.0,
    ),
    );
    String responseData;
    List<String> responses = [];
    if(_filePath.isNotEmpty) {
      for (var path in _filePath) {
        responseData = await _upLoadImage(path);
        responses.add(responseData);
      }
    }
    if(_ifFilled) {
      responseData =  await _upLoadWords(words);
      responses.add(responseData);
    }
    ProgressDialog.dismiss(context);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return ResultPage(response: responses,);
        })
    );
  }

  _upLoadImage(var imagePath) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagePath),
    });

    Dio dio = Dio();
    var response = await dio.post(
      'https://www.imoments.com.cn:8080/graphic',
      data: formData,
    );
    if (response.statusCode == 200) {
      return response.toString();
    }
  }

  _upLoadWords(String words) async {
    FormData formData = FormData.fromMap({
      "text": words,
    });

    Dio dio = Dio();
    var response = await dio.post(
      "https://www.imoments.com.cn:8080/word",
      data: formData,
    );
    if (response.statusCode == 200) {
      return response.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.picture_in_picture,
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
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            width: 70,
            child: ElevatedButton(
              child: Text('完成'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => (_ifFilled|| _filePath.isNotEmpty) ? iMomentsBlueButton : Colors.grey),
                foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),

              ),
              //color: (_ifFilled|| _filePath.isNotEmpty) ? iMomentsBlueButton : null ,
              onPressed: () {
                if(_ifFilled|| _filePath.isNotEmpty) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  printResult();
                }
              },
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '在此处输入你的文字',
                ),
                autofocus: false,
                maxLines: 7,
                style: TextStyle(
                  fontSize: 15,
                ),
                onChanged: (text) {
                  words = text;
                  if(text.isNotEmpty || _filePath.isNotEmpty) {
                    setState(() {
                      _ifFilled = true;
                    });
                  }
                  else {
                    setState(() {
                      _ifFilled = false;
                    });
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if( !_ifFilled && _filePath.isEmpty) {
                    return '请输入文字或上传图片';
                  }
                  else {
                    return null;
                  }
                },
              ),
            ),
          ),
          Divider(
            indent: 25,
            endIndent: 25,
            thickness: 1.5,
          ),
          GridView.builder(
            padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
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
                                    TextButton(
                                        child: Text('是'),
                                        onPressed: () {
                                          deleteImage(position);
                                          Navigator.of(context).pop(1);
                                        }
                                        ),
                                    TextButton(
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

//加载圈
class ProgressDialog {
  static bool _isShowing = false;

  ///展示
  static void showProgress(BuildContext context,
      {Widget child = const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue),)}) {
    if(!_isShowing) {
      _isShowing = true;
      Navigator.push(
        context,
        _PopRoute(
          child: _Progress(
            child: child,
          ),
        ),
      );
    }
  }

  ///隐藏
  static void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}

///Widget
class _Progress extends StatelessWidget {
  final Widget child;

  _Progress({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Center(
          child: child,
        ));
  }
}

///Route
class _PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  _PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
