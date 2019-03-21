import 'package:flutter/material.dart';

import './BasePage.dart';
import 'package:url_launcher/url_launcher.dart';

class AttendancePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new AttendancePageState();
}

class AttendancePageState extends State<AttendancePage>
{
  Widget build(BuildContext context)
  {
    return BasePage(
      "Attendance", 
      Colors.green, 
      Container(),
      onReload: () async => (){},
      icon: Icons.launch,
      buttonCall: () async {
                      if(await canLaunch("https://markattendance.webapps.snu.edu.in/"))
                      launch("https://markattendance.webapps.snu.edu.in/");
                      else
                      print("Can't open https://markattendance.webapps.snu.edu.in/");
                    },
    );
  }
}