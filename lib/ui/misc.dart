import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class GeneralCard extends StatefulWidget
{
  final Widget child;
  final Color color;
  final Color colorDark;
  final bool settles;
  final String title;

  final bool popUpMenuEnabled;
  final PopupMenuButton popUpMenu;

  GeneralCard({this.child, this.color, this.colorDark, this.settles = true, this.title = "Title", this.popUpMenu, this.popUpMenuEnabled =false, Key key}) : super(key:key);

  @override
  State createState() => new GeneralCardState();
}

class GeneralCardState extends State<GeneralCard> with SingleTickerProviderStateMixin
{
  AnimationController _animationController;
  Animation<double> _animation;

  void initState()
  {
    super.initState();

    _animationController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.addListener(() => this.setState((){}));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context)
  {
    return Card(
      color: widget.color,
      elevation: 10 * _animation.value,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5)
        )
      ),
      margin: EdgeInsets.fromLTRB(
        10, 
        20 - (10 * _animation.value), 
        10, 
        (10 * _animation.value) + 10
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10
                    ),
                    decoration: BoxDecoration(
                      color: widget.colorDark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        (widget.popUpMenuEnabled ? widget.popUpMenu : Container())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}