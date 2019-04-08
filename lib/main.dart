import 'package:flutter/material.dart';
import 'package:flutter_coloured_app_bar_with_animation/ColouredBottomBar/ColouredBarIcon.dart';
import 'package:flutter_coloured_app_bar_with_animation/ColouredBottomBar/ColouredBottomBarWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Coloured App Bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      bottomNavigationBar: ColouredBottomBarWidget(itemList: [
        ColouredBarIcon(title: "item 1", iconSrc:"assets/face.png", color: Colors.grey),
        ColouredBarIcon(title: "item 2", iconSrc:"assets/face.png", color: Colors.red),
        ColouredBarIcon(title: "item 3", iconSrc:"assets/face.png", color: Colors.red),
        ColouredBarIcon(title: "item 4", iconSrc:"assets/face.png", color: Colors.red),
      ],),
    );
  }
}
