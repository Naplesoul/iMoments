import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imoments/pages/post/showImage.dart';
import '../../custom_router.dart';
import './result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../userInfo.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => new _PostPageState();
}

class _PostPageState extends State<PostPage> {

  List<String> _filePath = [];
  bool _ifFilled = false;
  bool _ifHeadPoet = false;
  final ValueKey _formKey = ValueKey('form');
  final ValueKey _boxKey1 = ValueKey('box1');
  var serial;
  var groupValue = 0;
  var imageNum = 0;
  var wordNum = 0;
  String words;

  final picker = ImagePicker();

  Future getGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _filePath.add(image.path);
      } else {
        Fluttertoast.showToast(
          msg: "未选中照片",
        );
        imageNum--;
      }
    });
  }

  Future getCameraImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _filePath.add(image.path);
      } else {
        Fluttertoast.showToast(
          msg: "未选中照片",
        );
        imageNum--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void deleteImage(int index) {
    _filePath.removeAt(index);
    imageNum--;
    setState(() {
    });
  }

  Future printResult() async {
    var progressNum = _ifFilled ? imageNum + 1: imageNum;
    var currentNum = 0;
    ProgressDialog.showProgress(context, child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitRing(
          color: Colors.blue,
          size: 80.0,
        ),
        Text("$currentNum/$progressNum", style: TextStyle(fontSize: 14),),
      ],
    )
    );

    Timer(Duration(seconds: imageNum*5), () {
      print(currentNum);
    });

    var preRes = await Dio().get(storage_url + "new");
    var preJson = jsonDecode(preRes.data);
    serial = preJson;

    String responseData = "";
    List<String> responses = [];

    if(_ifFilled) {
      currentNum++;
      ProgressDialog.dismiss(context);
      ProgressDialog.showProgress(context, child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitRing(
            color: Colors.blue,
            size: 80.0,
          ),
          Text("$currentNum/$progressNum", style: TextStyle(fontSize: 14),),
        ],
      )
      );
      //续写歌词或散文
      responseData = await _upLoadWords(words);
      if (responseData == 'error') {
        return;
      }
      responses.add('   '+responseData);
      wordNum = 1;

      //藏头诗
      if (_ifHeadPoet) {
        wordNum=2;
        var textResponsePoem = words + ':\n';
        var poet = await AG.generate(words);
        responses.add(textResponsePoem + poet);
      }
    }
    if(_filePath.isNotEmpty) {
      for (var path in _filePath) {
        currentNum++;
        ProgressDialog.dismiss(context);
        ProgressDialog.showProgress(context, child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitRing(
              color: Colors.blue,
              size: 80.0,
            ),
            Text("$currentNum/$progressNum", style: TextStyle(fontSize: 14),),
          ],
        )
        );
        responseData = await _upLoadImage(path);
        if (responseData == 'error') {
          return;
        }
        responses.add(responseData);
      }
    }

    ProgressDialog.dismiss(context);
    await Future.delayed(Duration(milliseconds: 100), () {
      Navigator.of(context).push(CustomRouteFade(ResultPage(response: responses, filepath: _filePath, wordNum: wordNum,)));
    });
  }

  _upLoadImage(var imagePath) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagePath),
    });

    try {
      Dio dio = Dio();
      var response = await dio.post(
        storage_url + "graphic?token=" + storage_token + "&serial=$serial" + "&type=poem",
        data: formData,
      );
      if (response.statusCode == 200) {
        ProgressDialog.dismiss(context);
        return response.toString();
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        if(e.response.data['error'] == 'wrong token') {
          Fluttertoast.showToast(msg: "已在其他设备登录");
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
        Fluttertoast.showToast(msg: "sending message error!");
      }
      ProgressDialog.dismiss(context);
      return "error";
    }
  }

  _upLoadWords(String words) async {
    FormData formData = FormData.fromMap({
      "text": words,
    });

    try {
      var type = groupValue == 1 ? 'prose' : 'lyric';
      Dio dio = Dio();
      var response = await dio.post(
          storage_url + "words?token=" + storage_token + "&serial=$serial" + "&type=$type" ,
          data: formData,
          options: Options(responseType: ResponseType.plain)
      );

      if (response.statusCode == 200) {
        ProgressDialog.dismiss(context);
        return response.toString();
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        if(e.response.data['error'] == 'wrong token') {
          Fluttertoast.showToast(msg: "已在其他设备登录");
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
        Fluttertoast.showToast(msg: "sending message error!");
      }
      ProgressDialog.dismiss(context);
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Icon(Icons.public),
        title: Text(
          '生成朋友圈',
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            width: 70,
            child: ElevatedButton(
              child: Text('完成'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => (_ifFilled|| _filePath.isNotEmpty) ? null : Colors.grey),
                foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
              ),
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
            height: 170,
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
                maxLines: 50,
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
          Row(
            children: <Widget>[
              Row(
                ///包裹子布局
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    ///此单选框绑定的值 必选参数
                    value: 0,
                    ///当前组中这选定的值  必选参数
                    groupValue: groupValue,
                    ///点击状态改变时的回调 必选参数
                    onChanged: (v) {
                      setState(() {
                        this.groupValue = v;
                      });
                    },
                  ),
                  Text("续写歌词")
                ],
              ),
              Row(
                ///包裹子布局
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    ///此单选框绑定的值 必选参数
                    value: 1,
                    ///当前组中这选定的值  必选参数
                    groupValue: groupValue,
                    ///点击状态改变时的回调 必选参数
                    onChanged: (v) {
                      setState(() {
                        this.groupValue = v;
                      });
                    },
                  ),
                  Text("续写散文")
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: _ifHeadPoet,
                      key: _boxKey1,
                      onChanged: (newValue) {
                        setState(() {
                          _ifHeadPoet = newValue;
                        });
                      }
                  ),
                  Text("生成藏头诗"),
                ],
              )
            ],
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
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder){
                            return Container(
                              color: Colors.transparent,
                              height: 100,
                              child: Column(
                                children: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        imageNum++;
                                        getGalleryImage();
                                      },
                                      child: Text('从图库选择')
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        imageNum++;
                                        getCameraImage();
                                      },
                                      child: Text('照相')
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    },
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop(CustomRouteVerticalUp(PostPage()));
        },
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
          child: WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: _Progress(
              child: child,
            ),
          )
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
  final Duration _duration = Duration(milliseconds: 0);
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
