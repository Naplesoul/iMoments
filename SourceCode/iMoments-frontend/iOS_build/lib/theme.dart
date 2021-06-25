import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

List<Color> bgColors = [
  Color(0xff0560c0),
  Color(0xff424242),
  Color(0xffb2ff59),
  Color(0xffef9a9a),
  Color(0xffff3d00),
  Color(0xff37D4C4),
];

List<Color> selectedColors = [
  Color(0xff80d8ff),
  Color(0xff424242),
  Color(0xffccff90),
  Color(0xffef9a9a),
  Color(0xffff616f),
  Color(0xff6ADAC4),
];

AppTheme pinkTheme() {
  return AppTheme(
    id: 'pink',
    description: "Pink Color Scheme",
    data: ThemeData(
      scaffoldBackgroundColor: Color(0xffededed),
      primaryColor: Color(0xffffcdd2),
      buttonColor: Color(0xffef9a9a),
      iconTheme: IconThemeData(
        color: Color(0xffcb9ca1),
      ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white))
        ),
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 20),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      dialogBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: Color(0xffef9a9a)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xffef9a9a),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: Color(0xffffcccb),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) => Color(0xffef9a9a)),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) => Color(0xffef9a9a)),
      )
    ),
  );
}

AppTheme blackTheme() {
  return AppTheme(
    id: 'black',
    description: "Black Color Scheme",
    data: ThemeData(
        primaryColor: Color(0xff212121),
        bottomSheetTheme: BottomSheetThemeData(
          modalBackgroundColor: Color(0xff424242),
          backgroundColor: Color(0xff424242)
        ),
        scaffoldBackgroundColor: Color(0xff484848),
        buttonColor: Color(0xff424242),
        hintColor: Color(0xffe0e0e0),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white))
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Color(0xff212121),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          headline3: TextStyle(color: Colors.white),
          headline4: TextStyle(color: Colors.white),
          headline5: TextStyle(color: Colors.white),
          headline6: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 20),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        dialogBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Color(0xff424242)),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff424242),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Color(0xff202020),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Colors.black),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Colors.black),
        )
    ),
  );
}

AppTheme blueTheme() {
  return AppTheme(
    id: 'blue',
    description: "Blue Color Scheme",
    data: ThemeData(
        scaffoldBackgroundColor: Color(0xffededed),
        primaryColor: Color(0xff0277bd),
        buttonColor: Color(0xff80d8ff),
        iconTheme: IconThemeData(
          color: Color(0xff58a5f0),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 20),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        dialogBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white))
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Color(0xff004c8c)),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff80d8ff),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Color(0xff004c8c),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Color(0xff004c8c)),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Color(0xff004c8c)),
        )
    ),
  );
}

AppTheme redTheme() {
  return AppTheme(
    id: 'red',
    description: "Red Color Scheme",
    data: ThemeData(
        scaffoldBackgroundColor: Color(0xffededed),
        primaryColor: Color(0xffd50000),
        buttonColor: Color(0xffff1744),
        iconTheme: IconThemeData(
          color: Color(0xffff616f),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 20),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        dialogBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white))
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Color(0xffff1744)),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffff1744),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Color(0xff9b0000),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Color(0xff9b0000)),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Color(0xff9b0000)),
        )
    ),
  );
}

AppTheme greenTheme() {
  return AppTheme(
    id: 'green',
    description: "Green Color Scheme",
    data: ThemeData(
        scaffoldBackgroundColor: Color(0xffededed),
        primaryColor: Color(0xffccff90),
        buttonColor: Color(0xffb2ff59),
        iconTheme: IconThemeData(
          color: Color(0xff33691e),
        ),
        textTheme: TextTheme(
          headline5: TextStyle(color: Colors.black),
          headline6: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.black, fontSize: 20),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        dialogBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.black))
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Color(0xffb2ff59)),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffb2ff59),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Color(0xff99cc60),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Color(0xff99cc60)),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Color(0xff99cc60)),
        )
    ),
  );
}

AppTheme secretTheme() {
  return AppTheme(
    id: 'secret',
    description: "Secret Color Scheme",
    data: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xff37D4C4),
        buttonColor: Color(0xff95CAF0),
        iconTheme: IconThemeData(
          color: Color(0xff40F5AF),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white))
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 20),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        dialogBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Color(0xff95CAF0)),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff95CAF0),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Color(0xff37D4C4),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Color(0xff8DCAF5)),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) => Color(0xff8DCAF5)),
        )
    ),
  );
}