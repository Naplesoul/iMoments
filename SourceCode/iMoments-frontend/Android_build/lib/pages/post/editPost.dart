import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imoments/pages/post/showImage.dart';
import 'package:share/share.dart';

class EditPostPage extends StatefulWidget {
  final chosenLines;
  final List<String> filePath;
  EditPostPage({this.chosenLines, this.filePath});

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _contentsController = TextEditingController();
  List<String> _filePath = [];
  String words;
  bool _ifFilled = true;
  final ValueKey _formKey = ValueKey('form');

  @override
  void initState() {
    _filePath = widget.filePath;
    words = widget.chosenLines;
    _contentsController.text = words;
    super.initState();
  }

  void deleteImage(int index) {
    _filePath.removeAt(index);
    setState(() {
    });
  }

  _shareMenu() {
    if(_filePath.isEmpty) {
      Share.share(words);
    } else {
      Share.shareFiles(
        _filePath,
        text: words,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          '编辑并发送',
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            width: 70,
            child: ElevatedButton(
              child: Text('发送'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => (_ifFilled|| _filePath.isNotEmpty) ? null : Colors.grey),
                foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
              ),
              onPressed: () {
                if(_ifFilled|| _filePath.isNotEmpty) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _shareMenu();
                }
              },
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                height: 270,
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: _contentsController,
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
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(20),
                child: GestureDetector(
                  child: Icon(Icons.copy),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: words));
                    Fluttertoast.showToast(msg: "已复制到剪贴板");
                  },
                ),
              ),
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
          ),
        ],
      ),
    );
  }
}