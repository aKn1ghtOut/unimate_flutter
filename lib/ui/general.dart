import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GeneralCard extends StatefulWidget
{
  final Widget child;
  final Color color;
  final bool settles;

  GeneralCard({this.child, this.color, this.settles = true});

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
      color: Colors.white,
      elevation: 5.0,
      margin: EdgeInsets.fromLTRB(
        10, 
        20 - (10 * _animation.value), 
        10, 
        (10 * _animation.value) + 10
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Title",
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black
                      ),
                    )
                    // PopupMenuButton(
                    //   icon: new Icon(
                    //     FontAwesomeIcons.ellipsisV
                    //   ),
                    //   itemBuilder: (BuildContext context){
                    //     return
                    //   },
                    //   onSelected: ,
                    // )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}