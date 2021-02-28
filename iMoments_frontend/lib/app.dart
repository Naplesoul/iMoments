import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/gallery.dart';
import 'bottom_navigation.dart';

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