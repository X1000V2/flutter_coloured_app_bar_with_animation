import 'package:flutter/material.dart';
import 'package:flutter_coloured_app_bar_with_animation/ColouredBottomBar/ColouredBarIcon.dart';

class ColouredBottomBarWidget extends StatefulWidget {
  List<ColouredBarIcon> itemList;
  int indexButtonActive;
  int durationAnimationColor;
  int durationAnimationSize;
  Color activeIconColor;
  Color disableIconColor;
  final void Function(int) onIndexChanged;

  ColouredBottomBarWidget(
      {@required this.itemList,
      this.indexButtonActive,
      this.durationAnimationColor,
      this.durationAnimationSize,
      this.activeIconColor,
      this.disableIconColor,
      this.onIndexChanged});

  @override
  State<StatefulWidget> createState() {
    return ColouredBottomBarWidgetState();
  }
}

class ColouredBottomBarWidgetState extends State<ColouredBottomBarWidget>
    with TickerProviderStateMixin {

  static const double HEGHT_MAX = 50.0;
  static const double HEGHT_MIN = 40.0;

  //animation color
  AnimationController _animationController;
  Animation<Color> animationColor;
  Color _backGroundColor;

  //control size per icon
  List<double> _sizeIcon = [];

  //animation size next item
  AnimationController _animationControllerSizeNextItem;
  Animation<double> animationSizeNextItem;

  //animation size next item
  AnimationController _animationControllerSizeCurrentItem;
  Animation<double> animationSizeCurrentItem;
  
  //control color item
  List<Color> _backGroundColorText = [];

  //animate color next item
  AnimationController _animationControllerColorText;
  Animation<Color> _animationColorText;

  //animate color next item
  AnimationController _animationControllerCurrentColorText;
  Animation<Color> _animationCurrentColorText;

  @override
  void initState() {
    super.initState();

    //init array to control size icons
    widget.itemList.forEach((item){
      _sizeIcon.add(HEGHT_MIN);
      _backGroundColorText.add(Colors.black);
    });
    _sizeIcon[widget.indexButtonActive] = HEGHT_MAX;
    _backGroundColorText[widget.indexButtonActive] = Colors.white;
    
    _backGroundColor = widget.itemList[0].color;
  }

  void animateNextItemColor(ColouredBarIcon item) {
    //If the las animation is running, then stop it
    _animationController?.stop();

    //Create an animation for the color
    _animationController = AnimationController(
        duration: Duration(milliseconds: widget.durationAnimationColor),
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

  void animateSizeIcon(ColouredBarIcon item, int indexTapped){

    //restore size current image
    
    _animationControllerSizeCurrentItem?.stop();
    var currentIndex = widget.indexButtonActive;
    _animationControllerSizeCurrentItem = AnimationController(duration: Duration(milliseconds: widget.durationAnimationSize), vsync: this);
    animationSizeCurrentItem = Tween(begin: _sizeIcon[widget.indexButtonActive], end: HEGHT_MIN).animate(_animationControllerSizeCurrentItem);
    animationSizeCurrentItem.addListener((){
      setState((){
        _sizeIcon[currentIndex] = animationSizeCurrentItem.value;
      });
    });
    _animationControllerSizeCurrentItem.forward();

    //Animate the new current item
    _animationControllerSizeNextItem?.stop();

    _animationControllerSizeNextItem = AnimationController(duration: Duration(milliseconds: widget.durationAnimationSize), vsync: this);
    animationSizeNextItem = Tween(begin: HEGHT_MIN, end: HEGHT_MAX).animate(_animationControllerSizeNextItem);
    animationSizeNextItem.addListener((){
      setState((){
        _sizeIcon[indexTapped] = animationSizeNextItem.value;
      });
    });
    _animationControllerSizeNextItem.forward();
  }

  void animateTextColor(ColouredBarIcon item, int indexTapped){

    //animate current item
    _animationControllerCurrentColorText?.stop();
    var currentIndex = widget.indexButtonActive;
    _animationControllerCurrentColorText = AnimationController(duration: Duration(milliseconds: widget.durationAnimationSize), vsync: this);
    _animationCurrentColorText = ColorTween(begin: _backGroundColorText[currentIndex], end: widget.disableIconColor).animate(_animationControllerCurrentColorText);
    _animationCurrentColorText.addListener((){
      setState(() {
        _backGroundColorText[currentIndex] = _animationCurrentColorText.value;
      });
    });
    _animationControllerCurrentColorText.forward();

    //animate next item
    _animationControllerColorText?.stop();
    _animationControllerColorText = AnimationController(duration: Duration(milliseconds: widget.durationAnimationSize), vsync: this);
    _animationColorText = ColorTween(begin: _backGroundColorText[indexTapped], end: widget.activeIconColor).animate(_animationControllerColorText);
    _animationColorText.addListener((){
      setState(() {
        _backGroundColorText[indexTapped] = _animationColorText.value;
      });
    });
    _animationControllerColorText.forward();
  }

  void itemTaped(ColouredBarIcon item) {
    var indexTapped = widget.itemList.indexOf(item);

    if (indexTapped != widget.indexButtonActive) {
      
      //animate background color
      animateNextItemColor(item);
      animateSizeIcon(item, indexTapped);
      animateTextColor(item, indexTapped);
      widget.indexButtonActive = indexTapped;
      widget.onIndexChanged(widget.indexButtonActive);
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
      height: 66.0,
      width: 0.0,
      color: _backGroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.itemList
            .map((item) => 
            Center(
              child: GestureDetector(
                onTap: () => itemTaped(item),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: _sizeIcon[widget.itemList.indexOf(item)],
                      width: 80.0,
                      child: Image.asset(item.iconSrc,fit: BoxFit.fitHeight,color: _backGroundColorText[widget.itemList.indexOf(item)],)
                      ),
                    Text(item.title, style: TextStyle(color: _backGroundColorText[widget.itemList.indexOf(item)]),)
                  ],
                ),
              ),
            ))
            .toList(),
      ),
    );
  }
}
