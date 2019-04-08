import 'package:flutter/material.dart';
import 'package:flutter_coloured_app_bar_with_animation/ColouredBottomBar/ColouredBarIcon.dart';

class ColouredBottomBarWidget extends StatefulWidget {
  List<ColouredBarIcon> itemList;
  int indexButtonActive;
  int durationAnimations;

  ColouredBottomBarWidget(
      {@required this.itemList,
      this.indexButtonActive,
      this.durationAnimations});

  @override
  State<StatefulWidget> createState() {
    return ColouredBottomBarWidgetState();
  }
}

class ColouredBottomBarWidgetState extends State<ColouredBottomBarWidget>
    with TickerProviderStateMixin {
  //animation
  AnimationController _animationController;
  Animation<Color> animationColor;
  Color _backGroundColor;

  @override
  void initState() {
    super.initState();

    _backGroundColor = widget.itemList[0].color;
  }

  void animateNextItemColor(ColouredBarIcon item) {
    //If the las animation is running, then stop it
    _animationController?.stop();

    //Create an animation for the color
    _animationController = AnimationController(
        duration: Duration(milliseconds: widget.durationAnimations),
        vsync: this);

    animationColor = ColorTween(begin: _backGroundColor, end: item.color)
        .animate(_animationController);
    animationColor.addListener(() {

      //Save the current value and refresh the widget
      setState(() {
        _backGroundColor = animationColor.value;
      });
    });

    _animationController.forward();
  }

  void itemTaped(ColouredBarIcon item) {
    var indexTapped = widget.itemList.indexOf(item);

    if (indexTapped != widget.indexButtonActive) {
      
      //animate background color
      animateNextItemColor(item);
      widget.indexButtonActive = indexTapped;
    }
  }

  @override
  void dispose() {
    _animationController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 0.0,
      color: _backGroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.itemList
            .map((item) => Expanded(
                    child: Center(
                  child: GestureDetector(
                    onTap: () => itemTaped(item),
                    child: Column(
                      children: <Widget>[
                        Image.asset(item.iconSrc),
                        Text(item.title)
                      ],
                    ),
                  ),
                )))
            .toList(),
      ),
    );
  }
}
