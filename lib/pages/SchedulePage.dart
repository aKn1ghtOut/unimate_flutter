import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './BasePage.dart';

class SchedulePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new SchedulePageState();
}

class SchedulePageState extends State<SchedulePage>
{
  Widget build(BuildContext context)
  {
    return BasePage(
      title: "Schedule", 
      themeColor: Colors.blue, 
      inside: Container(),
      onReload: () async => (){},
      icon: Icons.launch,
      buttonCall: () async {
                      if(await canLaunch("https://prodweb.snu.in/psp/CSPROD/EMPLOYEE/HRMS/?cmd=login"))
                      launch("https://prodweb.snu.in/psp/CSPROD/EMPLOYEE/HRMS/?cmd=login");
                      else
                      print("Can't open https://prodweb.snu.in/psp/CSPROD/EMPLOYEE/HRMS/?cmd=login");
                    },
    );
  }
}