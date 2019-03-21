import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class TopBar extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return new Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0
      ),
      child: Row(
        children: <Widget>[
          new IconButton(
            icon: new Icon(
              FontAwesomeIcons.cog,
              color: Colors.white,
              size: 30.0,
            ),
            padding: EdgeInsets.all(10.0),
            onPressed: () => print("Settings pressed"),
          ),
          new Expanded(
            child: new Center(
              child: new Ink.image(
                height: 100.0,
                width: 100.0,
                image: AssetImage("assets/images/unimate.png"),
                child: InkWell(
                  onTap: () => print("Unimate pressed"),
                ),
                fit: BoxFit.contain,
              )
            )
          ),
          new IconButton(
            icon: new Icon(
              Icons.link,
              color: Colors.white,
              size: 30.0,
            ),
            padding: EdgeInsets.all(10.0),
            onPressed: launchSNULinks,
          ),
        ],
      ),
    );
  }

  Future<Null> launchSNULinks() async
  {
    var url = "https://snulinks.snu.edu.in";
    if(await canLaunch(url))
    launch(url);
    else
    print("Can't launch $url");
  }
}