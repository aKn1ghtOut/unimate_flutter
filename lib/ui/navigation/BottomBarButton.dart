import 'package:flutter/material.dart';

class BottomBarButton extends StatefulWidget
{

  final IconData _icon;
  final String _label;
  final ValueSetter<int> _onTap;
  final bool selected;
  final int index;
  final Color selectedColor;

  final BottombarButtonState bottombarButtonState = new BottombarButtonState();

  BottomBarButton(this._icon, this._label, this.index, this.selectedColor, this._onTap, {this.selected = false});

  @override
  State createState() => bottombarButtonState;

  void unClick() => bottombarButtonState.unClick();
}

class BottombarButtonState extends State<BottomBarButton> with SingleTickerProviderStateMixin {

  bool selected;
  double targetSize = 30.0;

  Animation<double> _iconSizeAnimation;
  AnimationController _iconSizeAnimationController;

  @override
  void initState()
  {
    super.initState();
    selected = widget.selected;

    _iconSizeAnimationController = new AnimationController(duration: new Duration(milliseconds: 200), vsync: this);
    _iconSizeAnimation = new CurvedAnimation(parent: _iconSizeAnimationController, curve: Curves.easeIn);

    _iconSizeAnimationController.addListener(() => this.setState((){}));

    if(selected)
    {
      _iconSizeAnimationController.forward();
    }
  }

  Widget build(BuildContext context)
  {
    return new Expanded(
      child: new Material(
        color: Theme.of(context).primaryColor,
        child: new InkWell(
          onTap: (){

            widget._onTap(widget.index);
            
            if(!selected)
              _iconSizeAnimationController.forward();

            setState((){
              selected = true;
            });
            
          },
          child: new Padding(
            padding: EdgeInsets.all(5.0),
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.fromLTRB(
                    6.0, 
                    6.0 - (_iconSizeAnimation.value * 6.0), 
                    6.0, 
                    6.0,
                  ),
                  child: new Icon(
                    widget._icon,
                    size: 25.0 ,//+ (_iconSizeAnimation.value * 12.0),
                    color: selected ? widget.selectedColor : Colors.white,
                  ),
                ),
                new Text(
                  widget._label,
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: (selected ? widget.selectedColor : Colors.white).withOpacity(_iconSizeAnimation.value),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void unClick()
  {
    if(selected)
    this._iconSizeAnimationController.reverse();
    this.setState((){
      selected = false;
    });
  }
}