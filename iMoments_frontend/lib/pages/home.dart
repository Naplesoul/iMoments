import 'package:flutter/material.dart';

String userName = "青铜葵花";

/*class IMoments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "iMomentsPage",
      home: HomePage(),
    );
  }
}
*/
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
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(left: 20, top: 25),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/loadingPic.png"),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 60, right: 16),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 12,),
                        child: Text(userName, style: TextStyle(fontSize: 20,),),
                      ),
                      Container(
                        child: Text("      ID:DongD_0706"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector( //我的动态
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return MyMomentsPage();
              }));
            }, //点击后跳转
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 1),
              ),
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
          GestureDetector( //收藏
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return MyFavorite();
              }));
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 1),
              ),
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
          GestureDetector( //设置
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return Settings();
              }));
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 1),
              ),
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
        ],
      ),
    );
  }

}
class MyMomentsPage extends StatefulWidget{
  @override
  _MyMomentsPage createState() => _MyMomentsPage();
}
class _MyMomentsPage extends State<MyMomentsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("我的动态"),
        actions: [
          Icon(Icons.search),
        ],
      ),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
class MyFavorite extends StatefulWidget{
  @override
  _MyFavorite createState() => _MyFavorite();
}
class _MyFavorite extends State<MyFavorite>{
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏"),
      ),
    );
  }
}
class Settings extends StatefulWidget{
  @override
  _Settings createState() => _Settings();
}
class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return EditName();
              }));},
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(200, 200, 200, 50), width: 1),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text("昵称"),
                      margin: const EdgeInsets.only(left: 20,),
                    ),
                  ),
                  Container(
                    child: Text("青铜葵花"),
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
          GestureDetector(
            onTap: null,
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(200, 200, 200, 50), width: 1),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text("头像"),
                      margin: const EdgeInsets.only(left: 20,),
                    ),
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
        ],
      ),
    );
  }
}
class EditName extends StatefulWidget{
  @override
  _EditName createState() => _EditName();
}
class _EditName extends State<EditName>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑昵称"),
        actions: [
          Icon(Icons.save)
        ],
      ),
      body: TextField(
        decoration: InputDecoration(
          hintText: "请输入修改后的昵称",
          labelText: "昵称",
        ),
        controller: new TextEditingController(),
        onChanged: (_) { userName = "你的东东";},
      ),
    );
  }
}