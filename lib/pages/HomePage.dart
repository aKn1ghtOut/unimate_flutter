import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './BasePage.dart';
import '../ui/general.dart';

class HomePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new HomePageState();
}

class HomePageState extends State<HomePage>
{
  Widget content;

  void initState()
  {
    super.initState();
    content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GeneralCard()
      ],
    );
  }

  Widget build(BuildContext context)
  {
    return BasePage(
      "Home", 
      Colors.yellow, 
      content,
      onReload: (){},
      icon: Icons.launch,
      buttonCall: () async {
                      if(await canLaunch("http://snulinks.snu.edu.in/"))
                      launch("http://snulinks.snu.edu.in/");
                      else
                      print("Can't open http://snulinks.snu.edu.in/");
                    },
    );
  }

}