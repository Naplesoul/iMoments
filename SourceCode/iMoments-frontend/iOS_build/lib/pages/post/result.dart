import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imoments/custom_router.dart';
import 'package:imoments/theme.dart';
import 'package:imoments/userInfo.dart';
import 'editPost.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ResultPage extends StatefulWidget {
  final List response;
  final List<String> filepath;
  final wordNum;

  ResultPage({this.response, this.filepath, this.wordNum});
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int num;
  int wordNum;
  int imageNum;
  List processedResponse = [];
  String _chosenLines = "";
  List ifSelected = [];
  bool _ifAnySelected = false;

  @override
  void initState() {
    num = widget.response.length;
    imageNum = widget.filepath.length;
    wordNum = widget.wordNum;
    for(int i = 0; i < num; i++) {
      ifSelected.add(false);
    }
    if (num == imageNum) {
      for(int i = 0; i < imageNum; i++) {
        processedResponse.add(_splitPoem(widget.response[i]));
      }
    } else {
      for(int i = 0; i < wordNum; i++) {
        processedResponse.add(widget.response[i]);
      }
      for(int i = 0; i < imageNum; i++) {
        processedResponse.add(_splitPoem(widget.response[i+wordNum]));
      }
    }
    super.initState();
  }

  _editPost() {
    for(int i = 0; i < num; i++) {
      if (ifSelected[i]) {
        _chosenLines += (processedResponse[i] + '\n');
      }
    }
    Navigator.of(context).push(CustomRouteFade(EditPostPage(chosenLines: _chosenLines, filePath: widget.filepath,)));
  }

  _splitPoem(lines) {
    List list = lines.split('\n');
    list.removeLast();
    var flag = false;
    var result = "";
    for(String i in list){
      if (i.startsWith('Poem:')){
        flag = true;
        continue;
      }
      if(flag){
        result += i + "\n";
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("生成结果"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _ifAnySelected ? null : Colors.grey,
        child: Icon(Icons.check),
        onPressed: () {
          if (_ifAnySelected) {
            _editPost();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: 
      StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(4),
              itemCount: num,
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              staggeredTileBuilder: (int index) => StaggeredTile.count(index < wordNum ? 2 : 1, index < wordNum ? 1.236 : 1.618),
              itemBuilder: (context, index) {
                var imgIndex = index - wordNum;
                var handPoem = false;
                if (wordNum == 2 && index == 1)
                  handPoem = true;
                //only words
                if (index < wordNum) {
                  return GestureDetector(
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(processedResponse[index] , style: handPoem ? GoogleFonts.zhiMangXing(textStyle: TextStyle(fontSize: 20, color: ifSelected[index] ? Colors.white: Colors.black),) :
                        TextStyle(color: ifSelected[index] ? Colors.white: Colors.black),),
                      ),
                      elevation: ifSelected[index] ? 13 : 2,
                      color: ifSelected[index] ? selectedColors[currentTheme]: Colors.white ,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
                    ),
                    onTap: () {
                      ifSelected[index] = ifSelected[index] ? false : true;
                      for (var s in ifSelected) {
                        if(s) {
                          _ifAnySelected = true;
                          break;
                        } else {
                          _ifAnySelected = false;
                        }
                      }
                      this.setState(() {

                      });
                    },
                  );
                }
                //image
                return GestureDetector(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(7, 7, 7, 12),
                          height: 150,
                          width: 200,
                          decoration: ShapeDecoration(
                              image: DecorationImage(
                                  image: FileImage(File(
                                      widget.filepath[imgIndex])),
                                  fit: BoxFit.cover),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional
                                      .circular(14))),
                        ),
                        Text(processedResponse[index], style: TextStyle(
                            color: ifSelected[index] ? Colors.white : Colors.black),),
                      ],
                    ),
                    elevation: ifSelected[index] ? 13 : 2,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14.0))),
                    color: ifSelected[index]
                        ? selectedColors[currentTheme]
                        : Colors.white,
                  ),
                  onTap: () {
                    ifSelected[index] = ifSelected[index] ? false : true;
                    for (var s in ifSelected) {
                      if (s) {
                        _ifAnySelected = true;
                        break;
                      } else {
                        _ifAnySelected = false;
                      }
                    }
                    this.setState(() {

                    });
                  },
                );
              }
       ),
    );
  }
}