import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'bottom_navigation.dart';
import 'colors.dart';

final ThemeData _iMomentsTheme = _buildiMomentsTheme();

ThemeData _buildiMomentsTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: iMomentsBlueButton,
    buttonColor: iMomentsBlueButton,
    textSelectionColor: iMomentsBlueWord,
    primaryColor: iMomentsBlueWord
  );
}

class ImApp extends StatefulWidget {
  @override
  _ImAppState createState() => _ImAppState();
}

class _ImAppState extends State<ImApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMoments',
      home: BottomNavigationWidget(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: _iMomentsTheme,
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name != '/login') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => LoginPage(),
    fullscreenDialog: true,
  );
}