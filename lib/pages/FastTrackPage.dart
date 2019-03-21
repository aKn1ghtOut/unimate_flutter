import 'package:flutter/material.dart';

import './BasePage.dart';
import 'package:url_launcher/url_launcher.dart';

class FastTrackPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new FastTrackPageState();
}

class FastTrackPageState extends State<FastTrackPage>
{
  Widget build(BuildContext context)
  {
    return BasePage(
      "Fast Track", 
      Colors.red, 
      Container(),
      onReload: () async => (){},
      icon: Icons.launch,
      buttonCall: () async {
                      if(await canLaunch("http://fastrack.webapps.snu.edu.in/"))
                      launch("http://fastrack.webapps.snu.edu.in/");
                      else
                      print("Can't open http://fastrack.webapps.snu.edu.in/");
                    },
    );
  }
}