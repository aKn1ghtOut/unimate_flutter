import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './BasePage.dart';

class ShoutBoxPage extends StatefulWidget
{
  final Key key;

  ShoutBoxPage({this.key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ShoutBoxPageState();
}

class ShoutBoxPageState extends State<ShoutBoxPage>
{
  Widget build(BuildContext context)
  {
    return BasePage(
      title: "ShoutBox", 
      themeColor: Colors.purple, 
      inside: Container(),
      onReload: () async => (){},
      icon: FontAwesomeIcons.plus,
    );
  }
}