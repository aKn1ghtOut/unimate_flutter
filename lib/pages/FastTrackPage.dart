import 'package:flutter/material.dart';

import './BasePage.dart';
import 'package:url_launcher/url_launcher.dart';

class FastTrackPage extends StatefulWidget
{

  final Key key;

  FastTrackPage({this.key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => new FastTrackPageState();
}

class FastTrackPageState extends State<FastTrackPage>
{
  Widget build(BuildContext context)
  {
    return BasePage(
      title: "Fast Track", 
      themeColor: Colors.red, 
      inside: Container(),
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