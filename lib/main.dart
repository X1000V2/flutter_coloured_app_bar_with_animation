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
              'Tap the bottom buttons ;)',
            ),
          ],
        ),
      ),
      bottomNavigationBar: ColouredBottomBarWidget(
        indexButtonActive: 0,
        durationAnimationColor: 1000,
        durationAnimationSize: 500,
        activeIconColor: Colors.white,
        disableIconColor: Colors.black,
        onIndexChanged: (newIndex){
          print("New Index: $newIndex");
        },
        itemList: [
          ColouredBarIcon(title: "red", iconSrc:"assets/comic.png", color: Colors.red),
          ColouredBarIcon(title: "green", iconSrc:"assets/hero.png", color: Colors.green),
          ColouredBarIcon(title: "blue", iconSrc:"assets/comic.png", color: Colors.blue),
      ],),
    );
  }
}
