import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './BasePage.dart';

class ShoutBoxPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new ShoutBoxPageState();
}

class ShoutBoxPageState extends State<ShoutBoxPage>
{
  Widget build(BuildContext context)
  {
    return BasePage(
      "ShoutBox", 
      Colors.purple, 
      Container(),
      onReload: () async {
        await new Future.delayed(const Duration(milliseconds: 2000));
        Scaffold.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 2000), content: Text("Hey")));
      },
      icon: FontAwesomeIcons.plus,
    );
  }
}