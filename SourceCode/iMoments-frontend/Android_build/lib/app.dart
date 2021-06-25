import 'package:flutter/material.dart';
import 'package:imoments/userInfo.dart';
import './pages/splashPage.dart';
import 'package:theme_provider/theme_provider.dart';
import 'pages/login.dart';
import 'bottom_navigation.dart';
import 'theme.dart';

class ImApp extends StatefulWidget {
  @override
  _ImAppState createState() => _ImAppState();
}

class _ImAppState extends State<ImApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      loadThemeOnInit: false,
      saveThemesOnChange: true,
      onInitCallback: (controller, previouslySavedThemeFuture) async {
          String savedTheme = await previouslySavedThemeFuture;
          if (savedTheme != null) {
            controller.setTheme(savedTheme);
            switch (savedTheme) {
              case 'blue': currentTheme = 0; break;
              case 'black': currentTheme = 1; break;
              case 'green': currentTheme = 2; break;
              case 'pink': currentTheme = 3; break;
              case 'red': currentTheme = 4; break;
              case 'secret': currentTheme = 5; break;
            }
          } else {
            controller.setTheme('blue');
            controller.forgetSavedTheme();
          }
      },
      themes: <AppTheme>[
        blueTheme(),
        blackTheme(),
        greenTheme(),
        pinkTheme(),
        redTheme(),
        secretTheme(),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            darkTheme: ThemeData(
                primaryColor: Color(0xff212121),
                scaffoldBackgroundColor: Color(0xff484848),
                buttonColor: Color(0xff424242),
                hintColor: Color(0xffe0e0e0),
                bottomSheetTheme: BottomSheetThemeData(
                    modalBackgroundColor: Color(0xff424242),
                    backgroundColor: Color(0xff424242)
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
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
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white))
                ),
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
            title: 'iMoments',
            home: BottomNavigationWidget(),
            initialRoute: '/splash',
            onGenerateRoute: _getRoute,
            routes: {
              "/login": (context) => LoginPage(),
            },
          ),
        ),
      )
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name != '/splash') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => SplashPage(),
    fullscreenDialog: true,
  );
}