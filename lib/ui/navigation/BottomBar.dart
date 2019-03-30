import 'package:flutter/material.dart';

import '../../util/MenuItem.dart';

import 'BottomBarButton.dart';

/*
 * TODO:
 *  1. Make the BottomBarButton more portable and independent
 *  2. Use the List map function to create the menu instead of the loop
*/

class BottomBar extends StatefulWidget
{
  final BottomBarState state = new BottomBarState();
  final List<MenuItem> menu;

  BottomBar(this.menu);

  @override
  BottomBarState createState() => state;
}

class BottomBarState extends State<BottomBar>
{

  final List<BottomBarButton> navButtons = [];
  Row iconRow;
  Color borderColor = Colors.yellowAccent;

  @override
  void initState()
  {
    super.initState();

    iconRow = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

      ],
    );

    ValueSetter<int> buttonOnTap = (int i)
    {
      widget.menu.elementAt(i).onTap();
      for(BottomBarButton button in iconRow.children)
      {
        button.unClick();
      }
      setState(() {
       borderColor =  widget.menu.elementAt(i).selectedColor;
      });
    };
    for(int i = 0; i < widget.menu.length; i++)
    {
      MenuItem curr = widget.menu.elementAt(i);

      iconRow.children.add(
        new BottomBarButton(
          curr.icon,
          curr.label, 
          i,
          curr.selectedColor,
          buttonOnTap,
          selected : curr.selected
        )
      );
    }
  }

  Widget build(BuildContext context)
  {
    return Container(
      child: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 0
                ),
                right: BorderSide(
                  width: 0
                ),
                bottom: BorderSide(
                  width: 0
                ),
                top: BorderSide(
                  width: 5,
                  color: this.borderColor
                )
              )
            ),
            child: iconRow
          )
        ],
      ),
    );
  }
}