import 'package:flutter/material.dart';
import 'package:imoments/userInfo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../theme.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetThemePage extends StatefulWidget {
  @override
  SetThemePageState createState() => new SetThemePageState();
}

class SetThemePageState extends State<SetThemePage> {
  var secretCode = "203";
  var pressedCode = "";
  Color backgroundColor;

  setColor (Color color) {
    setState(() {
      backgroundColor = color;
    });
  }

  _confirmCode() async {
    if(!secretThemeFlag && pressedCode.indexOf(secretCode) != -1) {
      Fluttertoast.showToast(msg: "secret Theme unlocked");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("secretTheme", true);
      secretThemeFlag = true;
      this.setState(() {

      });
    }
  }

  _getSecretButton(context) {
    if(secretThemeFlag) {
      print("yes");
      var controller = ThemeProvider.controllerOf(context);
      return ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.resolveWith((states) => Size(200,33)),
          backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xff37D4C4)),
        ),
        onPressed: () => {
          pressedCode += "5", _confirmCode(),
          controller.setTheme('secret'), setColor(bgColors[5])
        },
        child: Text("lightGreen"),
      );
    } else {
      return Container();
    }
}
  
  @override
  Widget build(BuildContext context) {
    var controller = ThemeProvider.controllerOf(context);
    Color color = Colors.white70;
    switch (controller.currentThemeId) {
      case 'blue': color = bgColors[0]; currentTheme = 0; break;
      case 'black': color = bgColors[1]; currentTheme = 1; break;
      case 'green': color = bgColors[2]; currentTheme = 2; break;
      case 'pink': color = bgColors[3]; currentTheme = 3; break;
      case 'red': color = bgColors[4]; currentTheme = 4; break;
      case 'secret': color = bgColors[5]; currentTheme = 5; break;
    }
    setColor(color);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("主题", style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith((states) => Size(200,33)),
                backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xff0277bd)),
              ),
              onPressed: () => {
                  pressedCode += "0", _confirmCode(),
                  controller.setTheme('blue'), setColor(bgColors[0])
                },
              child: Text("Blue"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith((states) => Size(200,33)),
                backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xff212121)),
              ),
              onPressed: () => {
                pressedCode += "1", _confirmCode(),
                controller.setTheme('black'), setColor(bgColors[1])
              },
              child: Text("Black"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith((states) => Size(200,33)),
                backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xffccff90)),
              ),
              onPressed: () => {
                pressedCode += "2", _confirmCode(),
                controller.setTheme('green'), setColor(bgColors[2])
              },
              child: Text("Green"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith((states) => Size(200,33)),
                backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xffffcdd2)),
              ),
              onPressed: () => {
                pressedCode += "3", _confirmCode(),
                controller.setTheme('pink'), setColor(bgColors[3])
              },
              child: Text("Pink"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith((states) => Size(200,33)),
                backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red),
              ),
              onPressed: () => {
                pressedCode += "4", _confirmCode(),
                controller.setTheme('red'), setColor(bgColors[4])
              },
              child: Text("Red"),
            ),
            _getSecretButton(context),
          ],
        ),
      ),
    );
  }
}
