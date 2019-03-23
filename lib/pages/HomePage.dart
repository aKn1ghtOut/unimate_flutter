import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../res/colors.dart';

import './BasePage.dart';
import '../ui/misc.dart';
import '../util/MessMenu.dart';

class HomePage extends StatefulWidget
{

  HomePage({Key key}) : super(key:key);

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
          title: "...",
          color: MyColors.greenLight,
          colorDark: MyColors.greenDark,
        ),
        GeneralCard(
          title: "...",
          color: MyColors.blueLight,
          colorDark: MyColors.blueDark,
        ),
        GeneralCard(
          title: "...",
          color: MyColors.greyLight,
          colorDark: MyColors.greyDark,
        ),
        MessMenuTabbed(
          color: MyColors.greyLight,
          colorDark: MyColors.greyDark,
          key: Key("hakuna_matata"),
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