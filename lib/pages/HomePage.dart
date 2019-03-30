import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../res/colors.dart';

import './BasePage.dart';
import '../ui/misc.dart';
import '../util/MessMenu.dart';

class HomePage extends StatefulWidget
{

  final MessMenuTabbed messMenuTabbed = MessMenuTabbed(
          color: MyColors.greyLight,
          colorDark: MyColors.greyDark
        );

  HomePage({Key key}) : super(key:key);

  @override
  State<HomePage> createState() => new HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin
{
  Widget content;

  @override
  bool get wantKeepAlive => true;

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
        widget.messMenuTabbed
      ],
    );
  }

  Widget build(BuildContext context)
  {
    return BasePage(
      title: "Home", 
      themeColor: Colors.yellow, 
      inside: content,
      onReload: () async {
        initState();
      },
      icon: Icons.launch,
      keyString: "homePageKey",
      key: Key("homePage BasePage"),
      buttonCall: () async {
        if(await canLaunch("http://snulinks.snu.edu.in/"))
          launch("http://snulinks.snu.edu.in/");
        else
          print("Can't open http://snulinks.snu.edu.in/");
      },
    );
  }

}