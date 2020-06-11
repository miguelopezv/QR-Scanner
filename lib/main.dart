import 'package:flutter/material.dart';
import './pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      initialRoute: 'home',
      routes: {'home': (BuildContext context) => HomePage()},
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}
