import 'package:flutter/material.dart';
import 'package:flutter_coloured_app_bar_with_animation/ColouredBottomBar/ColouredBarIcon.dart';

class ColouredBottomBarWidget extends StatefulWidget{

  List<ColouredBarIcon> itemList;

  ColouredBottomBarWidget({@required this.itemList});

  @override
  State<StatefulWidget> createState() {
   
    return ColouredBottomBarWidgetState();
  }
}

class ColouredBottomBarWidgetState extends State<ColouredBottomBarWidget>{
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 60.0,
      width: 0.0,
      color: Colors.greenAccent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.itemList.map((item)=> 
          Expanded(child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(item.iconSrc),
                Text(item.title)
              ],
            ),
          ))
        ).toList(),
      ),
    );
  }

}