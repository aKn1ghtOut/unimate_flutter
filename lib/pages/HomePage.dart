import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../res/colors.dart';

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
        GeneralCard(
          title: "C315",
          color: MyColors.greenLight,
          colorDark: MyColors.greenDark,
        ),
        GeneralCard(
          title: "D026",
          color: MyColors.blueLight,
          colorDark: MyColors.blueDark,
        ),
        GeneralCard(
          title: "Attendance",
          color: MyColors.greyLight,
          colorDark: MyColors.greyDark,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GeneralCard(
                title: "DH1",
                color: MyColors.greyLight,
                colorDark: MyColors.greyDark,
              ),
            ),
            Expanded(
              child: GeneralCard(
                title: "DH2",
                color: MyColors.greyLight,
                colorDark: MyColors.greyDark,
              ),
            )
          ],
        )
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