import 'package:flutter/material.dart';
import 'package:imoments/userInfo.dart';

import 'Settings.dart';

class MyMomentsPage extends StatefulWidget{
  @override
  _MyMomentsPage createState() => _MyMomentsPage();
}
class _MyMomentsPage extends State<MyMomentsPage> {
  List<Text> _date = [Text("2019-12-24", style: TextStyle(
    fontSize: 20, color: Colors.blue,),),];
  List<Image> _images = [Image(image: NetworkImage(
      storage_url + "portrait?token=" + storage_token),
    fit: BoxFit.contain,
  ),];
  List<Text> _verse = [Text(
    "明月几时有\n把酒问青天\n不知天上宫阙\n今夕是何年",
    style: TextStyle(fontSize: 18,),
    textAlign: TextAlign.center,
  )];
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("我的动态"),
        ),
        body:
            GridView.builder(
              padding: EdgeInsets.all(4.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {

                // List<Image> _moreImages = List<Image>.generate(
                //     50, (i) => Image.network(
                //   'https://www.imoments.com.cn/resource/img/3/${10 * i}.jpg',
                //   fit: BoxFit.cover,
                //    ),
                // );
                // _images.addAll(_moreImages);
                index = 0;
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Settings();
                        },
                      )).then((value) {
                        setState(() {

                        });
                      });
                    },
                    child:
                    Card(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
                      child:
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize:MainAxisSize.min,
                          children: [
                            SizedBox(width: 180, height: 30, child: _date[index],),
                            SizedBox(width: 180, height: 120, child: _verse[index],),
                            SizedBox(width: 300, height: 160, child: Row(
                              children: [
                                _images[index],
                                _images[index],
                              ],
                            ),),
                          ]
                      ),
                    )
                );
              },
            )
    );
  }
}